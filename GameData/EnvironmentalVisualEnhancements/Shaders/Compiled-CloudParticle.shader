Shader "EVE/CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_MainTex ("Main (RGB)", 2D) = "white" {}
	_DetailTex ("Detail (RGB)", 2D) = "white" {}
	_DetailScale ("Detail Scale", Range(0,1000)) = 100
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
//   d3d9 - ALU: 170 to 182, TEX: 2 to 2
//   d3d11 - ALU: 118 to 130, TEX: 0 to 0, FLOW: 1 to 1
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 177 ALU, 2 TEX
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
def c29, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c30, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c31, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c32, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c33, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c34, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c31.y, c31
mad r2.z, r2, r2.y, c31.w
mad r2.z, r2, r2.y, c32.x
mad r1.w, r2.z, r2.y, c32.y
slt r1.x, r1, c29
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad r2.y, r1.w, r2, c32.z
max r0.w, -r0, r0
slt r1.w, c29.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c30
mul r2.y, r0.w, r2
add r2.x, -r0.w, c32.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c29.x
max r0.w, -r0, r0
slt r1.w, c29.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c29.y, c29
mad r1.z, r1, r0.w, c29.w
mad r1.z, r1, r0.w, c30.x
add r0.w, -r0, c30.y
rsq r0.w, r0.w
add r2.y, -r2.x, c30.w
add r2.z, -r1.w, c30.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c29.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c29.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c30.z, r1
add r1.z, -r1.w, c30.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c29.x
mad r0.w, r0, c30, r1.x
mad r1.x, r1.y, c33, c33.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c31.x
mov r1.z, c29.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c30
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c33.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o9.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c33.z, c33.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c34.x, c34.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c34.x, c34.y
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
mov r0.xyz, v1
mov r0.w, c29.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c34.x, c34.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c34.z
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c34
mov r0.x, c28
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.x, v0, c2
mov o9.w, r4.z
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
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 142 instructions, 6 temp regs, 0 temp arrays:
// ALU 114 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhagffhjgjcjcaekgbojkfclhmjgapcbgabaaaaaagabfaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcgabdaaaa
eaaaabaaniaeaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaad
hccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaa
aaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaa
apaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaa
aeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaaj
icaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
aebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaa
akaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaa
jgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaai
ecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaabkaabaaa
acaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaa
aaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaa
acaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
adaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaai
aanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaadicaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaadccaaaak
hccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaa
aeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaa
amaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 353
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 451
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
#line 442
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 363
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 376
#line 384
#line 398
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 431
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 435
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 439
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 465
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 465
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 469
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 473
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 477
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 481
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 485
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 489
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 493
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 497
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 501
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 505
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 510
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
#line 353
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 451
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
#line 442
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 363
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 376
#line 384
#line 398
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 431
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 435
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 439
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 465
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 512
lowp vec4 frag( in v2f i ) {
    #line 514
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 518
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 522
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 526
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 530
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
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
Matrix 12 [_MainRotation]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 170 ALU, 2 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord8 o8
def c25, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c26, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c27, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c28, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c29, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c30, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c27.y, c27
mad r2.z, r2, r2.y, c27.w
mad r2.z, r2, r2.y, c28.x
mad r1.w, r2.z, r2.y, c28.y
slt r1.x, r1, c25
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c23.x
mad r2.y, r1.w, r2, c28.z
max r0.w, -r0, r0
slt r1.w, c25.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c26
mul r2.y, r0.w, r2
add r2.x, -r0.w, c28.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c25.x
max r0.w, -r0, r0
slt r1.w, c25.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c25.y, c25
mad r1.z, r1, r0.w, c25.w
mad r1.z, r1, r0.w, c26.x
add r0.w, -r0, c26.y
rsq r0.w, r0.w
add r2.y, -r2.x, c26.w
add r2.z, -r1.w, c26.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c25.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c25.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c26.z, r1
add r1.z, -r1.w, c26.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c25.x
mad r0.w, r0, c26, r1.x
mad r1.x, r1.y, c29, c29.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c27.x
mov r1.z, c25.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c26
mul_sat r0.x, r0, c22
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c29.y
mov r1.x, r5
mul r1.y, r5, c18.x
mad o8.xy, r5.z, c19.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c29.z, c29.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c30.x, c30.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c30.x, c30.y
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
mov r0.xyz, v1
mov r0.w, c25.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c20, c20
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c17
mul r2.xyz, r0.w, c20
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c30.x, c30.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c30.z
mul r0.y, r0, c21.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c30
mov r0.x, c24
add r0.xyz, c21, r0.x
mad_sat o7.xyz, r0, r0.w, c16
dp4 r0.x, v0, c2
mov o8.w, r4.z
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
ConstBuffer "$Globals" 240 // 224 used size, 12 vars
Matrix 16 [_MainRotation] 4
Vector 144 [_LightColor0] 4
Float 208 [_DistFade]
Float 212 [_DistFadeVert]
Float 220 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 134 instructions, 6 temp regs, 0 temp arrays:
// ALU 106 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddkepcncbppolmlajgdcbfolncpneihlkabaaaaaaambeaaaaadaaaaaa
cmaaaaaanmaaaaaaoaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
fdeieefccebcaaaaeaaaabaaijaeaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaaaaaaaaaa
acaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaa
aaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaaeaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaa
dkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaochgdidodcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaebnkjlo
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
diphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaia
ibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaajgafbaia
ebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
nlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
ddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadeaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaa
abaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
abaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
dkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaanaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaanaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaa
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
acaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaa
fganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
acaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
adaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaa
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
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
egiccaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaanaaaaaadccaaaakhccabaaa
agaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaahaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaahaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 351
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 449
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
#line 440
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 361
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 374
#line 382
#line 396
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 429
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 433
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 437
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 462
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 462
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 466
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 470
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 474
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 478
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 482
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 486
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 490
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 494
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 498
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 502
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    #line 506
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
#line 351
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 449
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
#line 440
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 361
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 374
#line 382
#line 396
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 429
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 433
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 437
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 462
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 508
lowp vec4 frag( in v2f i ) {
    #line 510
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 514
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 518
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 522
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 526
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 178 ALU, 2 TEX
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
def c29, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c30, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c31, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c32, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c33, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c34, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c31.y, c31
mad r2.z, r2, r2.y, c31.w
mad r2.z, r2, r2.y, c32.x
mad r1.w, r2.z, r2.y, c32.y
slt r1.x, r1, c29
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad r2.y, r1.w, r2, c32.z
max r0.w, -r0, r0
slt r1.w, c29.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c30
mul r2.y, r0.w, r2
add r2.x, -r0.w, c32.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c29.x
max r0.w, -r0, r0
slt r1.w, c29.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c29.y, c29
mad r1.z, r1, r0.w, c29.w
mad r1.z, r1, r0.w, c30.x
add r0.w, -r0, c30.y
rsq r0.w, r0.w
add r2.y, -r2.x, c30.w
add r2.z, -r1.w, c30.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c29.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c29.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c30.z, r1
add r1.z, -r1.w, c30.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c29.x
mad r0.w, r0, c30, r1.x
mad r1.x, r1.y, c33, c33.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c31.x
mov r1.z, c29.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c30
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c33.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o9.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c33.z, c33.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c34.x, c34.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c34.x, c34.y
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
mov r0.xyz, v1
mov r0.w, c29.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c34.x, c34.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c34.z
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c34
mov r0.x, c28
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.w, r0, c19
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.x, v0, c2
mov o9.w, r4.z
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
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 142 instructions, 6 temp regs, 0 temp arrays:
// ALU 114 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedffenipbnndnimcfacldkkincjjolhkbhabaaaaaagabfaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcgabdaaaa
eaaaabaaniaeaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaa
aaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaa
apaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaa
aeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaaj
icaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
aebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaa
akaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaa
jgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaai
ecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaabkaabaaa
acaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaa
aaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaa
acaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
adaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaai
aanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaadicaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaadccaaaak
hccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaa
aeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
pcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaaegaobaaa
acaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaalaaaaaakgakbaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaa
amaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 362
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 460
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
#line 451
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 353
uniform sampler2D _LightTextureB0;
#line 358
#line 372
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 385
#line 393
#line 407
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 440
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 444
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 448
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 474
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 474
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 478
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 482
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 486
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 490
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 494
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 498
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 502
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 506
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 510
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 514
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 519
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
#line 362
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 460
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
#line 451
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 353
uniform sampler2D _LightTextureB0;
#line 358
#line 372
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 385
#line 393
#line 407
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 440
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 444
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 448
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 474
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 521
lowp vec4 frag( in v2f i ) {
    #line 523
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 527
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 531
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 535
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 539
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 177 ALU, 2 TEX
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
def c29, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c30, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c31, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c32, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c33, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c34, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c31.y, c31
mad r2.z, r2, r2.y, c31.w
mad r2.z, r2, r2.y, c32.x
mad r1.w, r2.z, r2.y, c32.y
slt r1.x, r1, c29
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad r2.y, r1.w, r2, c32.z
max r0.w, -r0, r0
slt r1.w, c29.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c30
mul r2.y, r0.w, r2
add r2.x, -r0.w, c32.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c29.x
max r0.w, -r0, r0
slt r1.w, c29.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c29.y, c29
mad r1.z, r1, r0.w, c29.w
mad r1.z, r1, r0.w, c30.x
add r0.w, -r0, c30.y
rsq r0.w, r0.w
add r2.y, -r2.x, c30.w
add r2.z, -r1.w, c30.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c29.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c29.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c30.z, r1
add r1.z, -r1.w, c30.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c29.x
mad r0.w, r0, c30, r1.x
mad r1.x, r1.y, c33, c33.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c31.x
mov r1.z, c29.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c30
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c33.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o9.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c33.z, c33.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c34.x, c34.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c34.x, c34.y
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
mov r0.xyz, v1
mov r0.w, c29.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c34.x, c34.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c34.z
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c34
mov r0.x, c28
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.x, v0, c2
mov o9.w, r4.z
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
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 142 instructions, 6 temp regs, 0 temp arrays:
// ALU 114 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhagffhjgjcjcaekgbojkfclhmjgapcbgabaaaaaagabfaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcgabdaaaa
eaaaabaaniaeaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaad
hccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaa
aaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaa
apaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaa
aeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaaj
icaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
aebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaa
akaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaa
jgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaai
ecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaabkaabaaa
acaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaa
aaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaa
acaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
adaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaai
aanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaadicaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaadccaaaak
hccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaa
aeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaa
amaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 354
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 452
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
#line 443
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 353
uniform sampler2D _LightTextureB0;
#line 364
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 377
#line 385
#line 399
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 432
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 436
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 440
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 466
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 466
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 470
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 474
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 478
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 482
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 486
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 490
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 494
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 498
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 502
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 506
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 511
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
#line 354
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 452
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
#line 443
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 353
uniform sampler2D _LightTextureB0;
#line 364
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 377
#line 385
#line 399
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 432
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 436
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 440
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 466
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 513
lowp vec4 frag( in v2f i ) {
    #line 515
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 519
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 523
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 527
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 531
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 176 ALU, 2 TEX
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
def c29, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c30, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c31, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c32, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c33, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c34, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c31.y, c31
mad r2.z, r2, r2.y, c31.w
mad r2.z, r2, r2.y, c32.x
mad r1.w, r2.z, r2.y, c32.y
slt r1.x, r1, c29
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad r2.y, r1.w, r2, c32.z
max r0.w, -r0, r0
slt r1.w, c29.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c30
mul r2.y, r0.w, r2
add r2.x, -r0.w, c32.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c29.x
max r0.w, -r0, r0
slt r1.w, c29.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c29.y, c29
mad r1.z, r1, r0.w, c29.w
mad r1.z, r1, r0.w, c30.x
add r0.w, -r0, c30.y
rsq r0.w, r0.w
add r2.y, -r2.x, c30.w
add r2.z, -r1.w, c30.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c29.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c29.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c30.z, r1
add r1.z, -r1.w, c30.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c29.x
mad r0.w, r0, c30, r1.x
mad r1.x, r1.y, c33, c33.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c31.x
mov r1.z, c29.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c30
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c33.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o9.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c33.z, c33.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c34.x, c34.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c34.x, c34.y
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
mov r0.xyz, v1
mov r0.w, c29.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c34.x, c34.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c34.z
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c34
mov r0.x, c28
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.x, v0, c2
mov o9.w, r4.z
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
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 142 instructions, 6 temp regs, 0 temp arrays:
// ALU 114 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedehclhfofeoilgcbdcemijhnlkdgcllamabaaaaaagabfaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcgabdaaaa
eaaaabaaniaeaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadmccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
hccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaa
aaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaa
apaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaa
aeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaaj
icaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
aebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaa
akaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaa
jgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaai
ecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaabkaabaaa
acaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaa
aaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaa
acaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
adaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaai
aanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaaacaaaaaafgafbaaa
abaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aaaaaaaaajaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaalaaaaaakgakbaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaakmccabaaaaeaaaaaaagiecaaaaaaaaaaaamaaaaaapgapbaaaabaaaaaa
agaebaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaa
pgipcaaaaaaaaaaabbaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 353
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 451
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
#line 442
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 363
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 376
#line 384
#line 398
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 431
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 435
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 439
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 465
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 465
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 469
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 473
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 477
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 481
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 485
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 489
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 493
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 497
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 501
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 505
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 510
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
#line 353
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 451
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
#line 442
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 363
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 376
#line 384
#line 398
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 431
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 435
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 439
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 465
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 512
lowp vec4 frag( in v2f i ) {
    #line 514
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 518
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 522
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 526
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 530
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 182 ALU, 2 TEX
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
def c33, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c34, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c35, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c36, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c37, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c38, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c35.y, c35
mad r2.z, r2, r2.y, c35.w
mad r2.z, r2, r2.y, c36.x
mad r1.w, r2.z, r2.y, c36.y
slt r1.x, r1, c33
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c31.x
mad r2.y, r1.w, r2, c36.z
max r0.w, -r0, r0
slt r1.w, c33.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c34
mul r2.y, r0.w, r2
add r2.x, -r0.w, c36.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c33.x
max r0.w, -r0, r0
slt r1.w, c33.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c33.y, c33
mad r1.z, r1, r0.w, c33.w
mad r1.z, r1, r0.w, c34.x
add r0.w, -r0, c34.y
rsq r0.w, r0.w
add r2.y, -r2.x, c34.w
add r2.z, -r1.w, c34.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c33.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c33.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c34.z, r1
add r1.z, -r1.w, c34.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c33.x
mad r0.w, r0, c34, r1.x
mad r1.x, r1.y, c37, c37.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c35.x
mov r1.z, c33.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c34
mul_sat r0.x, r0, c30
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c37.y
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c37.z, c37.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c38.x, c38.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c38.x, c38.y
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
mov r0.xyz, v1
mov r0.w, c33.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c38.x, c38.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c38.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c38
mov r0.x, c32
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c23
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mov o10.w, r4.z
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
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 146 instructions, 6 temp regs, 0 temp arrays:
// ALU 118 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbeoiminleehjihfbiapkpnkoljajeffjabaaaaaacmbgaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcbebeaaaaeaaaabaaafafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaaaaaaaaaaacaaaaaafgifcaaa
aeaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaabaaaaaa
agiacaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaadaaaaaakgikcaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaaeaaaaaapgipcaaaaeaaaaaa
apaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaia
ibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaacaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaacaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
abaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
dbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaajgafbaiaebaaaaaaabaaaaaa
abaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaackaabaia
mbaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
aeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaaeaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaal
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
egbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaa
abaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaa
agaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaa
adaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaa
dcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaa
cgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaa
acaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
aeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaeaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaeaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
aeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaadicaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaapgipcaaaaaaaaaaabbaaaaaadccaaaakhccabaaaagaaaaaaegacbaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaajaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaamaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaa
adaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaaiaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaa
aiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 368
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 466
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
#line 457
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 358
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 378
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 391
#line 399
#line 413
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 446
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 450
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 454
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 481
#line 529
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 481
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 485
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 489
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 493
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 497
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 501
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 505
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 509
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 513
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 517
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 521
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 525
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
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
#line 368
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 466
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
#line 457
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 358
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 378
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 391
#line 399
#line 413
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 446
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 450
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 454
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 481
#line 529
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 529
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 533
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 537
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 541
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 545
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 182 ALU, 2 TEX
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
def c33, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c34, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c35, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c36, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c37, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c38, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c35.y, c35
mad r2.z, r2, r2.y, c35.w
mad r2.z, r2, r2.y, c36.x
mad r1.w, r2.z, r2.y, c36.y
slt r1.x, r1, c33
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c31.x
mad r2.y, r1.w, r2, c36.z
max r0.w, -r0, r0
slt r1.w, c33.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c34
mul r2.y, r0.w, r2
add r2.x, -r0.w, c36.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c33.x
max r0.w, -r0, r0
slt r1.w, c33.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c33.y, c33
mad r1.z, r1, r0.w, c33.w
mad r1.z, r1, r0.w, c34.x
add r0.w, -r0, c34.y
rsq r0.w, r0.w
add r2.y, -r2.x, c34.w
add r2.z, -r1.w, c34.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c33.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c33.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c34.z, r1
add r1.z, -r1.w, c34.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c33.x
mad r0.w, r0, c34, r1.x
mad r1.x, r1.y, c37, c37.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c35.x
mov r1.z, c33.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c34
mul_sat r0.x, r0, c30
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c37.y
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c37.z, c37.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c38.x, c38.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c38.x, c38.y
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
mov r0.xyz, v1
mov r0.w, c33.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c38.x, c38.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c38.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c38
mov r0.x, c32
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c23
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mov o10.w, r4.z
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
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 146 instructions, 6 temp regs, 0 temp arrays:
// ALU 118 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbeoiminleehjihfbiapkpnkoljajeffjabaaaaaacmbgaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcbebeaaaaeaaaabaaafafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaaaaaaaaaaacaaaaaafgifcaaa
aeaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaabaaaaaa
agiacaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaadaaaaaakgikcaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaaeaaaaaapgipcaaaaeaaaaaa
apaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaia
ibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaacaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaacaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
abaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
dbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaajgafbaiaebaaaaaaabaaaaaa
abaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaackaabaia
mbaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
aeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaaeaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaal
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
egbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaa
abaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaa
agaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaa
adaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaa
dcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaa
cgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaa
acaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
aeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaeaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaeaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
aeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaadicaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaapgipcaaaaaaaaaaabbaaaaaadccaaaakhccabaaaagaaaaaaegacbaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaajaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaamaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaa
adaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaaiaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaa
aiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 369
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 467
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
#line 458
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 358
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 379
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 392
#line 400
#line 414
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 447
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 451
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 455
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 482
#line 530
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 482
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 486
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 490
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 494
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 498
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 502
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 506
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 510
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 514
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 518
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 522
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 526
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
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
#line 369
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 467
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
#line 458
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 358
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 379
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 392
#line 400
#line 414
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 447
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 451
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 455
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 482
#line 530
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 530
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 534
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 538
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 542
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 546
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_36;
  vec4 tmpvar_37;
  tmpvar_37 = (tmpvar_4 * 0.5);
  vec2 tmpvar_38;
  tmpvar_38.x = tmpvar_37.x;
  tmpvar_38.y = (tmpvar_37.y * _ProjectionParams.x);
  o_36.xy = (tmpvar_38 + tmpvar_37.w);
  o_36.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = o_36;
  xlv_TEXCOORD8 = tmpvar_12;
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
Matrix 12 [_MainRotation]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 172 ALU, 2 TEX
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
def c25, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c26, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c27, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c28, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c29, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c30, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.z, c10.w
mov r2.x, c8.w
mov r2.y, c9.w
mov r2.w, c11
add r3.xyz, -r2, c17
dp3 r3.x, r3, r3
rsq r3.x, r3.x
rcp r4.x, r3.x
mul r4.y, -r4.x, c23.x
dp4 r0.z, r2, c14
dp4 r0.x, r2, c12
dp4 r0.y, r2, c13
dp3 r0.w, -r0, -r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, -r0
abs r0.w, r0.z
abs r1.x, r0
max r1.y, r0.w, r1.x
rcp r1.z, r1.y
min r1.y, r0.w, r1.x
mul r1.y, r1, r1.z
mul r1.z, r1.y, r1.y
slt r0.w, r0, r1.x
mad r1.w, r1.z, c27.y, c27.z
mad r1.w, r1, r1.z, c27
mad r1.w, r1, r1.z, c28.x
mad r1.x, r1.w, r1.z, c28.y
mad r1.x, r1, r1.z, c28.z
mul r1.x, r1, r1.y
max r0.w, -r0, r0
slt r0.w, c25.x, r0
slt r0.z, r0, c25.x
add r1.z, -r0.w, c26.y
add r1.y, -r1.x, c28.w
mul r1.x, r1, r1.z
mad r1.y, r0.w, r1, r1.x
max r0.z, -r0, r0
slt r1.x, c25, r0.z
abs r0.z, r0.y
mad r0.w, r0.z, c25.y, c25.z
mad r0.w, r0, r0.z, c25
mad r0.w, r0, r0.z, c26.x
add r1.z, -r1.y, c26.w
add r1.w, -r1.x, c26.y
mul r1.y, r1, r1.w
mad r1.y, r1.x, r1.z, r1
mov r1.w, v0
slt r1.x, r0, c25
add r0.z, -r0, c26.y
rsq r0.x, r0.z
max r0.z, -r1.x, r1.x
slt r1.x, c25, r0.z
rcp r0.x, r0.x
mul r0.z, r0.w, r0.x
slt r0.x, r0.y, c25
mul r0.y, r0.x, r0.z
mad r0.y, -r0, c26.z, r0.z
add r0.w, -r1.x, c26.y
mul r0.w, r1.y, r0
mad r0.z, r1.x, -r1.y, r0.w
mov r1.xyz, c25.x
mad r0.y, r0.x, c26.w, r0
mad r0.x, r0.z, c29, c29.y
dp4 r5.y, r1, c1
dp4 r5.x, r1, c0
dp4 r5.w, r1, c3
dp4 r5.z, r1, c2
add r2, r5, v0
dp4 r3.z, r2, c7
dp4 r3.y, r2, c5
dp4 r3.x, r2, c4
mov r3.w, r3.z
add_sat r4.y, r4, c26
mul_sat r4.x, r4, c22
mul r4.w, r4.x, r4.y
mul r4.xyz, r3.xyww, c29.y
mul r4.y, r4, c18.x
mad r4.xy, r4.z, c19.zwzw, r4
mul r0.y, r0, c27.x
mov r0.z, c25.x
texldl r0, r0.xyzz, s0
mov o1.xyz, r0
mul o1.w, r0, r4
dp4 r0.x, v0, c2
mov r4.z, -r0.x
mov r4.w, r3.z
dp4 r3.z, r2, c6
mad r2.xy, v2, c29.z, c29.w
dp3 r0.x, c2, c2
mov o0, r3
slt r0.z, r2.y, -r2.y
rsq r0.x, r0.x
mov o8.zw, r3
mov o8.xy, r4
mov o9, r4
mul r4.xyz, r0.x, c2
slt r0.y, -r4.x, r4.x
slt r0.x, r4, -r4
sub r0.x, r0, r0.y
slt r0.y, -r2, r2
sub r2.z, r0.y, r0
mul r0.z, r2.x, r0.x
mul r2.w, r0.x, r2.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r4.y, r2
mul r0.x, r0.y, r0
mad r0.x, r4.z, r0, r0.w
mov r2.w, v0
mov r0.yw, r2
dp4 r3.y, r0, c1
slt r3.x, r4.y, -r4.y
slt r3.z, -r4.y, r4.y
sub r3.z, r3.x, r3
dp4 r3.x, r0, c0
mul r0.x, r2, r3.z
add r3.xy, -r5, r3
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2, r3
mul r0.y, r0, r3.z
mul r3.z, r4, r0
mov r0.zw, r2.xyyw
mad r0.y, r4.x, r0, r3.z
dp4 r3.z, r0, c0
dp4 r3.w, r0, c1
add r0.xy, -r5, r3.zwzw
mad o4.xy, r0, c30.x, c30.y
slt r0.y, -r4.z, r4.z
slt r0.x, r4.z, -r4.z
sub r0.z, r0.y, r0.x
mul r2.x, r2, r0.z
sub r0.x, r0, r0.y
mul r0.w, r2.z, r0.x
slt r0.z, r2.x, -r2.x
slt r0.y, -r2.x, r2.x
sub r0.y, r0, r0.z
mul r0.z, r4.y, r0.w
mul r0.x, r0, r0.y
mad r2.z, r4.x, r0.x, r0
mov r0.xyz, v1
mov r0.w, c25.x
mad o3.xy, r3, c30.x, c30.y
dp4 r3.z, r0, c10
dp4 r3.x, r0, c8
dp4 r3.y, r0, c9
dp3 r0.z, r3, r3
dp4 r0.w, c20, c20
dp4 r0.x, r2, c0
dp4 r0.y, r2, c1
add r0.xy, -r5, r0
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
add r1.xyz, -r2, c17
rsq r0.w, r0.w
mul r2.xyz, r0.w, c20
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c30.x, c30.y
mul r0.xyz, r0.z, r3
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c30.z
mul r0.y, r0, c21.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c30
mov r0.x, c24
add r0.xyz, c21, r0.x
mad_sat o7.xyz, r0, r0.w, c16
abs o2.xyz, r4
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 136 instructions, 6 temp regs, 0 temp arrays:
// ALU 107 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhlpkhiocbbmigkeogkhlppbpphpmipleabaaaaaagabeaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcgabcaaaa
eaaaabaajiaeaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaa
aaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaa
apaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaa
aeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaajicaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajicaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakicaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaaddaaaaaj
bcaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ccaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaochgdido
dcaaaaajccaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
aebnkjlodcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadiphhpdpdiaaaaahccaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajecaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaa
akaabaiaibaaaaaaabaaaaaaabaaaaahccaabaaaacaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaabkaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaa
jgafbaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaanlapejmaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaaddaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakbcaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpdcaaaaakicaabaaaabaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaai
ecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaa
abaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaiccaabaaaacaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalbcaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaabbaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdgcaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaabkaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaa
acaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaahcaabaaa
aeaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaa
egacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaa
aeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaa
abaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaak
dcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaa
afaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaa
adaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaa
acaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaai
kcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaa
acaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
adaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaabaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaadbaaaaah
ecaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaabaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaabaaaaaangafbaaaacaaaaaaboaaaaai
ccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaaccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaacaaaaaaclaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaabbaaaaajicaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaknhcdlm
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaapnekibdpdiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadicaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaa
abaaaaaaagijcaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaadccaaaak
hccabaaaagaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaeaaaaaa
aeaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadgaaaaafpccabaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaflccabaaa
aiaaaaaaegambaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_49;
  tmpvar_49.x = tmpvar_48.x;
  tmpvar_49.y = (tmpvar_48.y * _ProjectionParams.x);
  o_47.xy = (tmpvar_49 + tmpvar_48.w);
  o_47.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = o_47;
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 359
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 457
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
#line 448
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 353
#line 369
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 382
#line 390
#line 404
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 437
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 441
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 445
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 471
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 471
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 475
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 479
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 483
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 487
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 491
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 495
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 499
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 503
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 507
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 511
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 516
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
#line 359
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 457
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
#line 448
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 353
#line 369
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 382
#line 390
#line 404
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 437
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 441
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 445
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 471
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 518
lowp vec4 frag( in v2f i ) {
    #line 520
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 524
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 528
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 532
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 536
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_36;
  vec4 tmpvar_37;
  tmpvar_37 = (tmpvar_4 * 0.5);
  vec2 tmpvar_38;
  tmpvar_38.x = tmpvar_37.x;
  tmpvar_38.y = (tmpvar_37.y * _ProjectionParams.x);
  o_36.xy = (tmpvar_38 + tmpvar_37.w);
  o_36.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD7 = o_36;
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 178 ALU, 2 TEX
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
def c29, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c30, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c31, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c32, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c33, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c34, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.z, c10.w
mov r2.x, c8.w
mov r2.y, c9.w
mov r2.w, c11
add r3.xyz, -r2, c21
dp3 r3.x, r3, r3
rsq r3.x, r3.x
rcp r4.x, r3.x
mul r4.y, -r4.x, c27.x
dp4 r0.z, r2, c14
dp4 r0.x, r2, c12
dp4 r0.y, r2, c13
dp3 r0.w, -r0, -r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, -r0
abs r0.w, r0.z
abs r1.x, r0
max r1.y, r0.w, r1.x
rcp r1.z, r1.y
min r1.y, r0.w, r1.x
mul r1.y, r1, r1.z
mul r1.z, r1.y, r1.y
slt r0.w, r0, r1.x
mad r1.w, r1.z, c31.y, c31.z
mad r1.w, r1, r1.z, c31
mad r1.w, r1, r1.z, c32.x
mad r1.x, r1.w, r1.z, c32.y
mad r1.x, r1, r1.z, c32.z
mul r1.x, r1, r1.y
max r0.w, -r0, r0
slt r0.w, c29.x, r0
slt r0.z, r0, c29.x
add r1.z, -r0.w, c30.y
add r1.y, -r1.x, c32.w
mul r1.x, r1, r1.z
mad r1.y, r0.w, r1, r1.x
max r0.z, -r0, r0
slt r1.x, c29, r0.z
abs r0.z, r0.y
mad r0.w, r0.z, c29.y, c29.z
mad r0.w, r0, r0.z, c29
mad r0.w, r0, r0.z, c30.x
add r1.z, -r1.y, c30.w
add r1.w, -r1.x, c30.y
mul r1.y, r1, r1.w
mad r1.y, r1.x, r1.z, r1
mov r1.w, v0
slt r1.x, r0, c29
add r0.z, -r0, c30.y
rsq r0.x, r0.z
max r0.z, -r1.x, r1.x
slt r1.x, c29, r0.z
rcp r0.x, r0.x
mul r0.z, r0.w, r0.x
slt r0.x, r0.y, c29
mul r0.y, r0.x, r0.z
mad r0.y, -r0, c30.z, r0.z
add r0.w, -r1.x, c30.y
mul r0.w, r1.y, r0
mad r0.z, r1.x, -r1.y, r0.w
mov r1.xyz, c29.x
mad r0.y, r0.x, c30.w, r0
mad r0.x, r0.z, c33, c33.y
dp4 r5.y, r1, c1
dp4 r5.x, r1, c0
dp4 r5.w, r1, c3
dp4 r5.z, r1, c2
add r2, r5, v0
dp4 r3.z, r2, c7
dp4 r3.y, r2, c5
dp4 r3.x, r2, c4
mov r3.w, r3.z
add_sat r4.y, r4, c30
mul_sat r4.x, r4, c26
mul r4.w, r4.x, r4.y
mul r4.xyz, r3.xyww, c33.y
mul r4.y, r4, c22.x
mad r4.xy, r4.z, c23.zwzw, r4
mul r0.y, r0, c31.x
mov r0.z, c29.x
texldl r0, r0.xyzz, s0
mov o1.xyz, r0
mul o1.w, r0, r4
dp4 r0.x, v0, c2
mov r4.z, -r0.x
mov r4.w, r3.z
dp4 r3.z, r2, c6
mad r2.xy, v2, c33.z, c33.w
dp3 r0.x, c2, c2
mov o0, r3
slt r0.z, r2.y, -r2.y
rsq r0.x, r0.x
mov o9.zw, r3
mov o9.xy, r4
mov o10, r4
mul r4.xyz, r0.x, c2
slt r0.y, -r4.x, r4.x
slt r0.x, r4, -r4
sub r0.x, r0, r0.y
slt r0.y, -r2, r2
sub r2.z, r0.y, r0
mul r0.z, r2.x, r0.x
mul r2.w, r0.x, r2.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r4.y, r2
mul r0.x, r0.y, r0
mad r0.x, r4.z, r0, r0.w
mov r2.w, v0
mov r0.yw, r2
dp4 r3.y, r0, c1
slt r3.x, r4.y, -r4.y
slt r3.z, -r4.y, r4.y
sub r3.z, r3.x, r3
dp4 r3.x, r0, c0
mul r0.x, r2, r3.z
add r3.xy, -r5, r3
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2, r3
mul r0.y, r0, r3.z
mul r3.z, r4, r0
mov r0.zw, r2.xyyw
mad r0.y, r4.x, r0, r3.z
dp4 r3.z, r0, c0
dp4 r3.w, r0, c1
add r0.xy, -r5, r3.zwzw
mad o4.xy, r0, c34.x, c34.y
slt r0.y, -r4.z, r4.z
slt r0.x, r4.z, -r4.z
sub r0.z, r0.y, r0.x
mul r2.x, r2, r0.z
sub r0.x, r0, r0.y
mul r0.w, r2.z, r0.x
slt r0.z, r2.x, -r2.x
slt r0.y, -r2.x, r2.x
sub r0.y, r0, r0.z
mul r0.z, r4.y, r0.w
mul r0.x, r0, r0.y
mad r2.z, r4.x, r0.x, r0
mov r0.xyz, v1
mov r0.w, c29.x
mad o3.xy, r3, c34.x, c34.y
dp4 r3.z, r0, c10
dp4 r3.x, r0, c8
dp4 r3.y, r0, c9
dp3 r0.z, r3, r3
dp4 r0.w, c24, c24
dp4 r0.x, r2, c0
dp4 r0.y, r2, c1
add r0.xy, -r5, r0
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
add r1.xyz, -r2, c21
rsq r0.w, r0.w
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c34.x, c34.y
mul r0.xyz, r0.z, r3
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c34.z
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c34
mov r0.x, c28
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
abs o2.xyz, r4
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 368 // 352 used size, 14 vars
Matrix 16 [_MainRotation] 4
Matrix 208 [_LightMatrix0] 4
Vector 272 [_LightColor0] 4
Float 336 [_DistFade]
Float 340 [_DistFadeVert]
Float 348 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 144 instructions, 6 temp regs, 0 temp arrays:
// ALU 115 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmlcapmbfhgceojjhnfojnokhngoelbdhabaaaaaalebfaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcjmbdaaaaeaaaabaaohaeaaaa
fjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
mccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
igibcaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaa
abaaaaaaigibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaa
adaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaa
aaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaaj
icaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajicaabaaaabaaaaaa
bkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakicaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaa
ddaaaaajbcaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
ccaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajccaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
ochgdidodcaaaaajccaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaaaebnkjlodcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaacaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajecaabaaaacaaaaaabkaabaiaibaaaaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaabaaaaahccaabaaaacaaaaaackaabaaa
acaaaaaabkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaa
abaaaaaajgafbaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaaddaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
bnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaak
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaabaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaaabaaaaaadkaabaaa
abaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaa
abaaaaaadkaabaaaabaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdp
aaaaaaaiecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaiccaabaaaacaaaaaa
akaabaaaacaaaaaaakiacaaaaaaaaaaabfaaaaaadccaaaalbcaabaaaacaaaaaa
bkiacaiaebaaaaaaaaaaaaaabfaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadp
dgcaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
dbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
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
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaa
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaabaaaaaadbaaaaah
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaabaaaaaangafbaaaacaaaaaa
boaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaabaaaaaa
cgaaaaaiaanaaaaaccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaacaaaaaa
claaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiacaaaaaaaaaaaaoaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaaaaaaaaaanaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaaapaaaaaakgakbaaaabaaaaaaegaabaaa
abaaaaaadcaaaaakmccabaaaaeaaaaaaagiecaaaaaaaaaaabaaaaaaapgapbaaa
abaaaaaaagaebaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaabbaaaaajicaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaapgapbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaadkiacaaaaaaaaaaabbaaaaaadicaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaa
bbaaaaaapgipcaaaaaaaaaaabfaaaaaadccaaaakhccabaaaagaaaaaajgahbaaa
abaaaaaaagaabaaaabaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaibcaabaaa
abaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaa
agadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaah
dcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafpccabaaa
ahaaaaaaegaobaaaaaaaaaaadgaaaaaflccabaaaaiaaaaaaegambaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
aiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_49;
  tmpvar_49.x = tmpvar_48.x;
  tmpvar_49.y = (tmpvar_48.y * _ProjectionParams.x);
  o_47.xy = (tmpvar_49 + tmpvar_48.w);
  o_47.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = o_47;
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 361
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 459
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
#line 450
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 353
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 371
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 384
#line 392
#line 406
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 439
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 443
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 447
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 474
#line 522
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 474
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 478
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 482
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 486
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 490
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 494
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 498
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 502
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 506
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 510
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 514
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 518
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
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
#line 361
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 459
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
#line 450
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 353
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 371
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 384
#line 392
#line 406
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 439
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 443
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 447
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 474
#line 522
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 522
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 526
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 530
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 534
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 538
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Vector 25 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 26 [_LightColor0]
Float 27 [_DistFade]
Float 28 [_DistFadeVert]
Float 29 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 178 ALU, 2 TEX
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
def c30, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c31, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c32, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c33, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c34, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c35, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c32.y, c32
mad r2.z, r2, r2.y, c32.w
mad r2.z, r2, r2.y, c33.x
mad r1.w, r2.z, r2.y, c33.y
slt r1.x, r1, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c28.x
mad r2.y, r1.w, r2, c33.z
max r0.w, -r0, r0
slt r1.w, c30.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c31
mul r2.y, r0.w, r2
add r2.x, -r0.w, c33.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c30.x
max r0.w, -r0, r0
slt r1.w, c30.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c30.y, c30
mad r1.z, r1, r0.w, c30.w
mad r1.z, r1, r0.w, c31.x
add r0.w, -r0, c31.y
rsq r0.w, r0.w
add r2.y, -r2.x, c31.w
add r2.z, -r1.w, c31.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c30.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c30.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c31.z, r1
add r1.z, -r1.w, c31.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c30.x
mad r0.w, r0, c31, r1.x
mad r1.x, r1.y, c34, c34.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c32.x
mov r1.z, c30.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c31
mul_sat r0.x, r0, c27
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c34.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o10.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c34.z, c34.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c35.x, c35.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c35.x, c35.y
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
mov r0.xyz, v1
mov r0.w, c30.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c35.x, c35.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c35.z
mul r0.y, r0, c26.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c35
mov r0.x, c29
add r0.xyz, c26, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c25
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 144 instructions, 6 temp regs, 0 temp arrays:
// ALU 116 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhpgjmchfcmffocjgpnnhlajobdkocfocabaaaaaanabfaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefclibdaaaaeaaaabaaooaeaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadhccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
igibcaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaa
abaaaaaaigibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaa
adaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaa
aaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaaj
ecaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaa
bkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaa
ddaaaaajicaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
ochgdidodcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaaaebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaa
abaaaaaajgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
bnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdp
aaaaaaaiecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
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
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaacaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaahaaaaaaegiccaaaaaaaaaaaamaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 366
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 464
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
#line 455
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
#line 364
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 376
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 389
#line 397
#line 411
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 444
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 448
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 452
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 479
#line 527
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 479
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 483
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 487
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 491
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 495
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 499
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 503
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 507
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 511
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 515
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 519
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 523
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
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
#line 366
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 464
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
#line 455
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
#line 364
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 376
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 389
#line 397
#line 411
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 444
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 448
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 452
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 479
#line 527
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 527
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 531
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 535
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 539
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 543
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Vector 25 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 26 [_LightColor0]
Float 27 [_DistFade]
Float 28 [_DistFadeVert]
Float 29 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 178 ALU, 2 TEX
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
def c30, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c31, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c32, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c33, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c34, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c35, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c32.y, c32
mad r2.z, r2, r2.y, c32.w
mad r2.z, r2, r2.y, c33.x
mad r1.w, r2.z, r2.y, c33.y
slt r1.x, r1, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c28.x
mad r2.y, r1.w, r2, c33.z
max r0.w, -r0, r0
slt r1.w, c30.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c31
mul r2.y, r0.w, r2
add r2.x, -r0.w, c33.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c30.x
max r0.w, -r0, r0
slt r1.w, c30.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c30.y, c30
mad r1.z, r1, r0.w, c30.w
mad r1.z, r1, r0.w, c31.x
add r0.w, -r0, c31.y
rsq r0.w, r0.w
add r2.y, -r2.x, c31.w
add r2.z, -r1.w, c31.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c30.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c30.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c31.z, r1
add r1.z, -r1.w, c31.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c30.x
mad r0.w, r0, c31, r1.x
mad r1.x, r1.y, c34, c34.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c32.x
mov r1.z, c30.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c31
mul_sat r0.x, r0, c27
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c34.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o10.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c34.z, c34.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c35.x, c35.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c35.x, c35.y
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
mov r0.xyz, v1
mov r0.w, c30.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c35.x, c35.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c35.z
mul r0.y, r0, c26.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c35
mov r0.x, c29
add r0.xyz, c26, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c25
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 144 instructions, 6 temp regs, 0 temp arrays:
// ALU 116 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhpgjmchfcmffocjgpnnhlajobdkocfocabaaaaaanabfaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefclibdaaaaeaaaabaaooaeaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadhccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
igibcaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaa
abaaaaaaigibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaa
adaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaa
aaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaaj
ecaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaa
bkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaa
ddaaaaajicaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
ochgdidodcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaaaebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaa
abaaaaaajgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
bnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdp
aaaaaaaiecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
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
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaacaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaahaaaaaaegiccaaaaaaaaaaaamaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 367
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 465
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
#line 456
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
#line 364
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 377
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 390
#line 398
#line 412
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 445
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 449
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 453
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 480
#line 528
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 484
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 488
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 492
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 496
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 500
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 504
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 508
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 512
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 516
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 520
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 524
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
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
#line 367
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 465
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
#line 456
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
#line 364
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 377
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 390
#line 398
#line 412
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 445
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 449
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 453
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 480
#line 528
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 528
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 532
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 536
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 540
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 544
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 182 ALU, 2 TEX
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
def c33, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c34, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c35, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c36, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c37, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c38, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c35.y, c35
mad r2.z, r2, r2.y, c35.w
mad r2.z, r2, r2.y, c36.x
mad r1.w, r2.z, r2.y, c36.y
slt r1.x, r1, c33
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c31.x
mad r2.y, r1.w, r2, c36.z
max r0.w, -r0, r0
slt r1.w, c33.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c34
mul r2.y, r0.w, r2
add r2.x, -r0.w, c36.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c33.x
max r0.w, -r0, r0
slt r1.w, c33.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c33.y, c33
mad r1.z, r1, r0.w, c33.w
mad r1.z, r1, r0.w, c34.x
add r0.w, -r0, c34.y
rsq r0.w, r0.w
add r2.y, -r2.x, c34.w
add r2.z, -r1.w, c34.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c33.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c33.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c34.z, r1
add r1.z, -r1.w, c34.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c33.x
mad r0.w, r0, c34, r1.x
mad r1.x, r1.y, c37, c37.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c35.x
mov r1.z, c33.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c34
mul_sat r0.x, r0, c30
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c37.y
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c37.z, c37.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c38.x, c38.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c38.x, c38.y
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
mov r0.xyz, v1
mov r0.w, c33.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c38.x, c38.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c38.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c38
mov r0.x, c32
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c23
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mov o10.w, r4.z
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
ConstBuffer "$Globals" 368 // 352 used size, 14 vars
Matrix 16 [_MainRotation] 4
Matrix 208 [_LightMatrix0] 4
Vector 272 [_LightColor0] 4
Float 336 [_DistFade]
Float 340 [_DistFadeVert]
Float 348 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 146 instructions, 6 temp regs, 0 temp arrays:
// ALU 118 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaidfompgoihicmnjokeecokmhbakoiaaabaaaaaacmbgaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcbebeaaaaeaaaabaaafafaaaa
fjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaaaaaaaaaaacaaaaaafgifcaaa
aeaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaabaaaaaa
agiacaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaadaaaaaakgikcaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaaeaaaaaapgipcaaaaeaaaaaa
apaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaia
ibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaacaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaacaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
abaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
dbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaajgafbaiaebaaaaaaabaaaaaa
abaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaackaabaia
mbaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bfaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabfaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
aeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaaeaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaal
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
egbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaa
abaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaa
agaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaa
adaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaa
dcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaa
cgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaa
acaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
aeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaeaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaeaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
aeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaadkiacaaaaaaaaaaabbaaaaaadicaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
bbaaaaaapgipcaaaaaaaaaaabfaaaaaadccaaaakhccabaaaagaaaaaaegacbaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaanaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaapaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaabaaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaa
adaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaaiaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaa
aiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 376
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 474
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
#line 465
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 353
#line 365
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 386
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 399
#line 407
#line 421
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 454
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 458
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 462
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 489
#line 537
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 489
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 493
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 497
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 501
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 505
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 509
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 513
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 517
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 521
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 525
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 529
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 533
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
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
#line 376
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 474
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
#line 465
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 353
#line 365
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 386
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 399
#line 407
#line 421
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 454
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 458
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 462
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 489
#line 537
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 537
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 541
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 545
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 549
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 553
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 182 ALU, 2 TEX
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
def c33, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c34, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c35, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c36, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c37, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c38, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c35.y, c35
mad r2.z, r2, r2.y, c35.w
mad r2.z, r2, r2.y, c36.x
mad r1.w, r2.z, r2.y, c36.y
slt r1.x, r1, c33
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c31.x
mad r2.y, r1.w, r2, c36.z
max r0.w, -r0, r0
slt r1.w, c33.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c34
mul r2.y, r0.w, r2
add r2.x, -r0.w, c36.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c33.x
max r0.w, -r0, r0
slt r1.w, c33.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c33.y, c33
mad r1.z, r1, r0.w, c33.w
mad r1.z, r1, r0.w, c34.x
add r0.w, -r0, c34.y
rsq r0.w, r0.w
add r2.y, -r2.x, c34.w
add r2.z, -r1.w, c34.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c33.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c33.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c34.z, r1
add r1.z, -r1.w, c34.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c33.x
mad r0.w, r0, c34, r1.x
mad r1.x, r1.y, c37, c37.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c35.x
mov r1.z, c33.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c34
mul_sat r0.x, r0, c30
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c37.y
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c37.z, c37.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c38.x, c38.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c38.x, c38.y
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
mov r0.xyz, v1
mov r0.w, c33.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c38.x, c38.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c38.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c38
mov r0.x, c32
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c23
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mov o10.w, r4.z
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
ConstBuffer "$Globals" 368 // 352 used size, 14 vars
Matrix 16 [_MainRotation] 4
Matrix 208 [_LightMatrix0] 4
Vector 272 [_LightColor0] 4
Float 336 [_DistFade]
Float 340 [_DistFadeVert]
Float 348 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 146 instructions, 6 temp regs, 0 temp arrays:
// ALU 118 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaidfompgoihicmnjokeecokmhbakoiaaabaaaaaacmbgaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcbebeaaaaeaaaabaaafafaaaa
fjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaigibcaaaaaaaaaaaacaaaaaafgifcaaa
aeaaaaaaapaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaabaaaaaa
agiacaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
igibcaaaaaaaaaaaadaaaaaakgikcaaaaeaaaaaaapaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaaeaaaaaapgipcaaaaeaaaaaa
apaaaaaaegacbaaaabaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaia
ibaaaaaaabaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaacaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaacaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaa
abaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
dbaaaaaidcaabaaaacaaaaaajgafbaaaabaaaaaajgafbaiaebaaaaaaabaaaaaa
abaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaackaabaia
mbaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bfaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabfaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
aeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaaeaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaal
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
egbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaa
abaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaa
agaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaa
adaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaa
dcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaa
cgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaa
acaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
aeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaaeaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaeaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
aeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaadkiacaaaaaaaaaaabbaaaaaadicaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
bbaaaaaapgipcaaaaaaaaaaabfaaaaaadccaaaakhccabaaaagaaaaaaegacbaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaanaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaapaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaabaaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaa
adaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaaiaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaa
aiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 376
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 474
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
#line 465
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 353
#line 365
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 386
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 399
#line 407
#line 421
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 454
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 458
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 462
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 489
#line 537
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 489
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 493
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 497
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 501
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 505
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 509
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 513
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 517
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 521
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 525
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 529
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 533
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
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
#line 376
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 474
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
#line 465
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 353
#line 365
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 386
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 399
#line 407
#line 421
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 454
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 458
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 462
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 489
#line 537
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 537
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 541
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 545
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 549
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 553
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Vector 25 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 26 [_LightColor0]
Float 27 [_DistFade]
Float 28 [_DistFadeVert]
Float 29 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 178 ALU, 2 TEX
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
def c30, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c31, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c32, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c33, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c34, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c35, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c32.y, c32
mad r2.z, r2, r2.y, c32.w
mad r2.z, r2, r2.y, c33.x
mad r1.w, r2.z, r2.y, c33.y
slt r1.x, r1, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c28.x
mad r2.y, r1.w, r2, c33.z
max r0.w, -r0, r0
slt r1.w, c30.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c31
mul r2.y, r0.w, r2
add r2.x, -r0.w, c33.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c30.x
max r0.w, -r0, r0
slt r1.w, c30.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c30.y, c30
mad r1.z, r1, r0.w, c30.w
mad r1.z, r1, r0.w, c31.x
add r0.w, -r0, c31.y
rsq r0.w, r0.w
add r2.y, -r2.x, c31.w
add r2.z, -r1.w, c31.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c30.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c30.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c31.z, r1
add r1.z, -r1.w, c31.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c30.x
mad r0.w, r0, c31, r1.x
mad r1.x, r1.y, c34, c34.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c32.x
mov r1.z, c30.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c31
mul_sat r0.x, r0, c27
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c34.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o10.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c34.z, c34.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c35.x, c35.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c35.x, c35.y
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
mov r0.xyz, v1
mov r0.w, c30.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c35.x, c35.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c35.z
mul r0.y, r0, c26.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c35
mov r0.x, c29
add r0.xyz, c26, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c25
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 144 instructions, 6 temp regs, 0 temp arrays:
// ALU 116 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhpgjmchfcmffocjgpnnhlajobdkocfocabaaaaaanabfaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefclibdaaaaeaaaabaaooaeaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadhccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
igibcaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaa
abaaaaaaigibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaa
adaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaa
aaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaaj
ecaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaa
bkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaa
ddaaaaajicaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
ochgdidodcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaaaebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaa
abaaaaaajgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
bnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdp
aaaaaaaiecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
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
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaacaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaahaaaaaaegiccaaaaaaaaaaaamaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 372
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 470
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
#line 461
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 371
uniform highp mat4 _LightMatrix0;
#line 382
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 395
#line 403
#line 417
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 450
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 454
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 458
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 485
#line 533
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 485
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 489
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 493
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 497
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 501
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 505
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 509
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 513
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 517
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 521
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 525
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 529
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
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
#line 372
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 470
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
#line 461
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 371
uniform highp mat4 _LightMatrix0;
#line 382
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 395
#line 403
#line 417
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 450
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 454
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 458
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 485
#line 533
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 533
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 537
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 541
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 545
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 549
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
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _MainRotation;


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
  vec3 tmpvar_6;
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec4 tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = gl_Vertex.w;
  vec4 tmpvar_14;
  tmpvar_14 = (gl_ModelViewMatrix * tmpvar_13);
  tmpvar_4 = (gl_ProjectionMatrix * (tmpvar_14 + gl_Vertex));
  vec4 v_15;
  v_15.x = gl_ModelViewMatrix[0].z;
  v_15.y = gl_ModelViewMatrix[1].z;
  v_15.z = gl_ModelViewMatrix[2].z;
  v_15.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(v_15.xyz);
  tmpvar_6 = abs(tmpvar_16);
  vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = gl_Vertex.w;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_17).xyz));
  vec2 tmpvar_18;
  tmpvar_18 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_19;
  tmpvar_19.z = 0.0;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = tmpvar_18.y;
  tmpvar_19.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_19.zyw;
  XZv_2.yzw = tmpvar_19.zyw;
  XYv_1.yzw = tmpvar_19.yzw;
  ZYv_3.z = (tmpvar_18.x * sign(-(tmpvar_16.x)));
  XZv_2.x = (tmpvar_18.x * sign(-(tmpvar_16.y)));
  XYv_1.x = (tmpvar_18.x * sign(tmpvar_16.z));
  ZYv_3.x = ((sign(-(tmpvar_16.x)) * sign(ZYv_3.z)) * tmpvar_16.z);
  XZv_2.y = ((sign(-(tmpvar_16.y)) * sign(XZv_2.x)) * tmpvar_16.x);
  XYv_1.z = ((sign(-(tmpvar_16.z)) * sign(XYv_1.x)) * tmpvar_16.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_16.x)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_16.y)) * sign(tmpvar_18.y)) * tmpvar_16.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_16.z)) * sign(tmpvar_18.y)) * tmpvar_16.y));
  tmpvar_7 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_14.xy)));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_14.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_14.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = gl_Normal;
  tmpvar_11 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_21).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(-((_MainRotation * tmpvar_20).xyz));
  vec2 uv_23;
  float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    float s_26;
    float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_MainTex, uv_23, 0.0);
  tmpvar_5.xyz = tmpvar_28.xyz;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  vec4 p_30;
  p_30 = (tmpvar_20 - tmpvar_29);
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  vec4 p_32;
  p_32 = (tmpvar_20 - tmpvar_31);
  tmpvar_5.w = (tmpvar_28.w * (clamp ((_DistFade * sqrt(dot (p_30, p_30))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_32, p_32)))), 0.0, 1.0)));
  vec4 o_33;
  vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * 0.5);
  vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_34.x;
  tmpvar_35.y = (tmpvar_34.y * _ProjectionParams.x);
  o_33.xy = (tmpvar_35 + tmpvar_34.w);
  o_33.zw = tmpvar_4.zw;
  tmpvar_12.xyw = o_33.xyw;
  tmpvar_12.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_12;
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
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Vector 25 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_LightMatrix0]
Vector 26 [_LightColor0]
Float 27 [_DistFade]
Float 28 [_DistFadeVert]
Float 29 [_MinLight]
SetTexture 0 [_MainTex] 2D
"vs_3_0
; 178 ALU, 2 TEX
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
def c30, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c31, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c32, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c33, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c34, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c35, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
mov r2.w, v0
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
abs r1.w, r1.x
abs r0.w, r1.z
max r2.x, r0.w, r1.w
rcp r2.y, r2.x
min r2.x, r0.w, r1.w
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
slt r0.w, r0, r1
mad r2.z, r2.y, c32.y, c32
mad r2.z, r2, r2.y, c32.w
mad r2.z, r2, r2.y, c33.x
mad r1.w, r2.z, r2.y, c33.y
slt r1.x, r1, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c28.x
mad r2.y, r1.w, r2, c33.z
max r0.w, -r0, r0
slt r1.w, c30.x, r0
mul r0.w, r2.y, r2.x
add r2.y, -r1.w, c31
mul r2.y, r0.w, r2
add r2.x, -r0.w, c33.w
mad r2.x, r1.w, r2, r2.y
slt r0.w, r1.z, c30.x
max r0.w, -r0, r0
slt r1.w, c30.x, r0
abs r0.w, r1.y
mad r1.z, r0.w, c30.y, c30
mad r1.z, r1, r0.w, c30.w
mad r1.z, r1, r0.w, c31.x
add r0.w, -r0, c31.y
rsq r0.w, r0.w
add r2.y, -r2.x, c31.w
add r2.z, -r1.w, c31.y
mul r2.x, r2, r2.z
mad r2.x, r1.w, r2.y, r2
max r1.x, -r1, r1
slt r1.w, c30.x, r1.x
rcp r0.w, r0.w
mul r1.x, r1.z, r0.w
slt r0.w, r1.y, c30.x
mul r1.y, r0.w, r1.x
mad r1.x, -r1.y, c31.z, r1
add r1.z, -r1.w, c31.y
mul r1.z, r2.x, r1
mad r1.y, r1.w, -r2.x, r1.z
mov r2.xyz, c30.x
mad r0.w, r0, c31, r1.x
mad r1.x, r1.y, c34, c34.y
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul r1.y, r0.w, c32.x
mov r1.z, c30.x
texldl r1, r1.xyzz, s0
mov r0.w, r4.z
mov o1.xyz, r1
add_sat r0.y, r0, c31
mul_sat r0.x, r0, c27
mul r0.x, r0, r0.y
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mul r5.xyz, r0.xyww, c34.y
mov r1.x, r5
mul r1.y, r5, c22.x
mad o10.xy, r5.z, c23.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c34.z, c34.w
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
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r4, r5
mad o3.xy, r5, c35.x, c35.y
slt r4.w, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4
mul r0.x, r1, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r4, r5.zwzw
mad o4.xy, r0, c35.x, c35.y
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
mov r0.xyz, v1
mov r0.w, c30.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c24, c24
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c21
mul r2.xyz, r0.w, c24
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c35.x, c35.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c35.z
mul r0.y, r0, c26.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c35
mov r0.x, c29
add r0.xyz, c26, r0.x
mad_sat o7.xyz, r0, r0.w, c20
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c25
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 304 // 288 used size, 13 vars
Matrix 16 [_MainRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 284 [_MinLight]
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
SetTexture 0 [_MainTex] 2D 0
// 144 instructions, 6 temp regs, 0 temp arrays:
// ALU 116 float, 8 int, 4 uint
// TEX 0 (1 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhpgjmchfcmffocjgpnnhlajobdkocfocabaaaaaanabfaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefclibdaaaaeaaaabaaooaeaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadhccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
igibcaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaa
abaaaaaaigibcaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaaaaaaaaaaadaaaaaakgikcaaa
adaaaaaaapaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaigibcaaa
aaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaaegacbaaaabaaaaaabaaaaaaj
ecaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaajecaabaaaaaaaaaaa
bkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaaoaaaaakecaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaa
ddaaaaajicaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaakaabaiaibaaaaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
ochgdidodcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaaaebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaacaaaaaabkaabaiaibaaaaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaaidcaabaaaacaaaaaajgafbaaa
abaaaaaajgafbaiaebaaaaaaabaaaaaaabaaaaahicaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
bnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdp
aaaaaaaiecaabaaaabaaaaaackaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
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
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaapgipcaaaaaaaaaaabbaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaacaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaahaaaaaaegiccaaaaaaaaaaaamaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaajaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _MainRotation;
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
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = _glesVertex.w;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_modelview0 * tmpvar_16);
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_17 + _glesVertex));
  vec4 v_18;
  v_18.x = glstate_matrix_modelview0[0].z;
  v_18.y = glstate_matrix_modelview0[1].z;
  v_18.z = glstate_matrix_modelview0[2].z;
  v_18.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(v_18.xyz);
  tmpvar_9 = abs(tmpvar_19);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_20.w = _glesVertex.w;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_20).xyz));
  highp vec2 tmpvar_21;
  tmpvar_21 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_21.y;
  tmpvar_22.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_22.zyw;
  XZv_5.yzw = tmpvar_22.zyw;
  XYv_4.yzw = tmpvar_22.yzw;
  ZYv_6.z = (tmpvar_21.x * sign(-(tmpvar_19.x)));
  XZv_5.x = (tmpvar_21.x * sign(-(tmpvar_19.y)));
  XYv_4.x = (tmpvar_21.x * sign(tmpvar_19.z));
  ZYv_6.x = ((sign(-(tmpvar_19.x)) * sign(ZYv_6.z)) * tmpvar_19.z);
  XZv_5.y = ((sign(-(tmpvar_19.y)) * sign(XZv_5.x)) * tmpvar_19.x);
  XYv_4.z = ((sign(-(tmpvar_19.z)) * sign(XYv_4.x)) * tmpvar_19.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_19.x)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_19.y)) * sign(tmpvar_21.y)) * tmpvar_19.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_19.z)) * sign(tmpvar_21.y)) * tmpvar_19.y));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_17.xy)));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_17.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_17.xy)));
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (normalize((_Object2World * tmpvar_24).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_28)), 0.0, 1.0);
  tmpvar_14 = tmpvar_29;
  mediump vec4 tex_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(-((_MainRotation * tmpvar_23).xyz));
  highp vec2 uv_32;
  highp float r_33;
  if ((abs(tmpvar_31.z) > (1e-08 * abs(tmpvar_31.x)))) {
    highp float y_over_x_34;
    y_over_x_34 = (tmpvar_31.x / tmpvar_31.z);
    highp float s_35;
    highp float x_36;
    x_36 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
    s_35 = (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))));
    r_33 = s_35;
    if ((tmpvar_31.z < 0.0)) {
      if ((tmpvar_31.x >= 0.0)) {
        r_33 = (s_35 + 3.14159);
      } else {
        r_33 = (r_33 - 3.14159);
      };
    };
  } else {
    r_33 = (sign(tmpvar_31.x) * 1.5708);
  };
  uv_32.x = (0.5 + (0.159155 * r_33));
  uv_32.y = (0.31831 * (1.5708 - (sign(tmpvar_31.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_31.y))) * (1.5708 + (abs(tmpvar_31.y) * (-0.214602 + (abs(tmpvar_31.y) * (0.0865667 + (abs(tmpvar_31.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DLod (_MainTex, uv_32, 0.0);
  tex_30 = tmpvar_37;
  tmpvar_8 = tex_30;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = _WorldSpaceCameraPos;
  highp vec4 p_39;
  p_39 = (tmpvar_23 - tmpvar_38);
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (tmpvar_23 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp ((_DistFade * sqrt(dot (p_39, p_39))), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_41, p_41)))), 0.0, 1.0);
  tmpvar_8.w = (tmpvar_8.w * (tmpvar_42 * tmpvar_43));
  highp vec4 o_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_46;
  tmpvar_46.x = tmpvar_45.x;
  tmpvar_46.y = (tmpvar_45.y * _ProjectionParams.x);
  o_44.xy = (tmpvar_46 + tmpvar_45.w);
  o_44.zw = tmpvar_7.zw;
  tmpvar_15.xyw = o_44.xyw;
  tmpvar_15.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_15;
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
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return textureLod( s, coord.xy, coord.w);
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
#line 373
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 471
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
#line 462
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 371
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 383
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 396
#line 404
#line 418
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 451
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 455
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 459
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 486
#line 534
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 334
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 336
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    #line 340
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 486
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 490
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 494
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 498
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 502
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 506
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 510
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 514
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 518
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 522
    highp vec3 planet_pos = (_MainRotation * origin).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, (-planet_pos));
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    #line 526
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 530
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
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
#line 373
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 471
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
#line 462
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 371
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 383
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 396
#line 404
#line 418
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 451
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 455
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 459
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 486
#line 534
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 534
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 538
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 542
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 546
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 550
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedldcjkkgccjbebkapbdkfmjnajlmkkjhkabaaaaaabeafaaaaadaaaaaa
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
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaae
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
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
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
ConstBuffer "$Globals" 240 // 228 used size, 12 vars
Vector 192 [_Color] 4
Float 224 [_InvFade]
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
eefiecedcmfejolgkncgdhakanblccgingdkbaemabaaaaaapmaeaaaaadaaaaaa
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
apaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
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
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaadiaaaaahpcaabaaaabaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedmdmmkopdakfgeacbjmogonjljlcacchoabaaaaaabeafaaaaadaaaaaa
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
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaae
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
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedldcjkkgccjbebkapbdkfmjnajlmkkjhkabaaaaaabeafaaaaadaaaaaa
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
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaae
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
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedjenlcnboponghmelfphbgdcjldlekgcoabaaaaaabeafaaaaadaaaaaa
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
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaae
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
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedgmpnnloogbjlohbpdiccjegnkpjlofejabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedgmpnnloogbjlohbpdiccjegnkpjlofejabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecedmdmmkopdakfgeacbjmogonjljlcacchoabaaaaaabeafaaaaadaaaaaa
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
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaae
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
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
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
ConstBuffer "$Globals" 368 // 356 used size, 14 vars
Vector 320 [_Color] 4
Float 352 [_InvFade]
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
eefiecedbkaikdnejlhmlgombdnhfghodekgcadbabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabgaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecediegpigegmdibnegnhbdkadnoaapejonlabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecediegpigegmdibnegnhbdkadnoaapejonlabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 368 // 356 used size, 14 vars
Vector 320 [_Color] 4
Float 352 [_InvFade]
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
eefiecedlbeogoikpkblmjlekdcnclepakjapdmhabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabgaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 368 // 356 used size, 14 vars
Vector 320 [_Color] 4
Float 352 [_InvFade]
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
eefiecedlbeogoikpkblmjlekdcnclepakjapdmhabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabgaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecediegpigegmdibnegnhbdkadnoaapejonlabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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
ConstBuffer "$Globals" 304 // 292 used size, 13 vars
Vector 256 [_Color] 4
Float 288 [_InvFade]
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
eefiecediegpigegmdibnegnhbdkadnoaapejonlabaaaaaacmafaaaaadaaaaaa
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
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakiacaaaaaaaaaaabcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
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

#LINE 190
 
		}
		
	} 
	
}
}