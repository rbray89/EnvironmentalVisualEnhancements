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
//   d3d9 - ALU: 191 to 203, TEX: 4 to 4
//   d3d11 - ALU: 138 to 150, TEX: 0 to 0, FLOW: 1 to 1
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DetailScale]
Float 31 [_DistFade]
Float 32 [_DistFadeVert]
Float 33 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 198 ALU, 4 TEX
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
def c34, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c35, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c36, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c37, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c38, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c39, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c32.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c38.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c36.y, c36
mad r3.z, r2, r3.y, c36.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c37.x
mad r1.w, r3.z, r3.y, c37.y
mad r3.y, r1.w, r3, c37.z
max r0.w, -r0, r0
slt r1.w, c34.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c35
add r3.x, -r0.w, c37.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c34.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c34, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c35.y
add r3.y, -r1.w, c35.w
mad r0.w, r1.z, c34.y, c34.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c34
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c35.x
slt r3.x, r1, c34
add r1.z, -r1, c35.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c34, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c34
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c35.y
mad r1.y, -r1, c35.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c35, r1.y
mad r1.x, r1.z, c38, c38.y
mul r1.y, r0.w, c36.x
mov r1.z, c34.x
add_sat r0.y, r0, c35
mul_sat r0.x, r0, c31
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c30.x
mov r2.z, c34.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c34.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c38.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o9.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c38.z, c38.w
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
mad o3.xy, r5, c39.x, c39.y
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
mad o4.xy, r0, c39.x, c39.y
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
mov r0.w, c34.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c39.x, c39.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c39.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c39
mov r0.x, c33
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 165 instructions, 6 temp regs, 0 temp arrays:
// ALU 132 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfeehfbnmkgndngahcnnocadebmikfecaabaaaaaahabiaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefchabgaaaa
eaaaabaajmafaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaa
apaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaa
adaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaa
egaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
bgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
afaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaaj
ecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaj
pcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaa
diaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaa
adaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaa
kgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaak
gcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaa
diaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaa
acaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaa
abaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
dbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaa
abaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaackaabaia
mbaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaa
dccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaah
iccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaag
ecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaa
aaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaa
agaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
adaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaa
kgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaa
acaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaa
abaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
aeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
acaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaa
adaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaa
fgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaa
dbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaa
aaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaa
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
kgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hccabaaaahaaaaaaegiccaaaaaaaaaaaamaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 378
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 476
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
#line 467
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
#line 388
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 401
#line 409
#line 423
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 456
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 460
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 464
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 490
#line 539
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 490
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 494
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 498
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 502
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 506
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 510
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 514
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 518
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 522
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 526
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 530
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 534
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
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
#line 378
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 476
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
#line 467
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
#line 388
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 401
#line 409
#line 423
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 456
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 460
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 464
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 490
#line 539
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 539
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 543
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 547
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 551
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 555
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Vector 25 [_LightColor0]
Float 26 [_DetailScale]
Float 27 [_DistFade]
Float 28 [_DistFadeVert]
Float 29 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 191 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord8 o8
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
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c28.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c34.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c32.y, c32
mad r3.z, r2, r3.y, c32.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c33.x
mad r1.w, r3.z, r3.y, c33.y
mad r3.y, r1.w, r3, c33.z
max r0.w, -r0, r0
slt r1.w, c30.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c31
add r3.x, -r0.w, c33.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c30.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c30, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c31.y
add r3.y, -r1.w, c31.w
mad r0.w, r1.z, c30.y, c30.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c30
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c31.x
slt r3.x, r1, c30
add r1.z, -r1, c31.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c30, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c30
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c31.y
mad r1.y, -r1, c31.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c31, r1.y
mad r1.x, r1.z, c34, c34.y
mul r1.y, r0.w, c32.x
mov r1.z, c30.x
add_sat r0.y, r0, c31
mul_sat r0.x, r0, c27
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c26.x
mov r2.z, c30.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c30.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c34.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c22.x
mad o8.xy, r5.z, c23.zwzw, r1
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
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c35
mov r0.x, c29
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
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
Matrix 80 [_DetailRotation] 4
Vector 144 [_LightColor0] 4
Float 176 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 157 instructions, 6 temp regs, 0 temp arrays:
// ALU 124 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedepplpiendklcgobicfaogmdfdnmjbegoabaaaaaabmbhaaaaadaaaaaa
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
fdeieefcdebfaaaaeaaaabaaenafaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaaapaaaaaa
dcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaaadaaaaaa
apaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaa
adaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaa
acaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaaegaobaaa
acaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaabgigcaaa
aaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaafaaaaaa
agaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaa
bgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaajecaabaaa
aaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajpcaabaaa
aeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaadiaaaaah
ecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaaadaaaaaa
dgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaahocaabaaa
abaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaakgakbaaa
aaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaakgcaabaaa
abaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaa
aoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaai
dcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaeiaaaaal
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaaacaaaaaa
deaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaa
acaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaa
acaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaa
adaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaa
adaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabaaaaah
bcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadbaaaaai
dcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaaabaaaaah
icaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaadkaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
dkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaackaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaa
iedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaackaabaiambaaaaaa
acaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
bcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadccaaaal
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaanaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaa
abaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
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
aaaaaaaaajaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaapgipcaaa
aaaaaaaaanaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 487
#line 535
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 487
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 491
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 495
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 499
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 503
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 507
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 511
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 515
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 519
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 523
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 527
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 531
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
#line 487
#line 535
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 535
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 539
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 543
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 547
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 551
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DetailScale]
Float 31 [_DistFade]
Float 32 [_DistFadeVert]
Float 33 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 199 ALU, 4 TEX
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
def c34, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c35, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c36, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c37, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c38, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c39, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c32.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c38.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c36.y, c36
mad r3.z, r2, r3.y, c36.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c37.x
mad r1.w, r3.z, r3.y, c37.y
mad r3.y, r1.w, r3, c37.z
max r0.w, -r0, r0
slt r1.w, c34.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c35
add r3.x, -r0.w, c37.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c34.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c34, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c35.y
add r3.y, -r1.w, c35.w
mad r0.w, r1.z, c34.y, c34.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c34
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c35.x
slt r3.x, r1, c34
add r1.z, -r1, c35.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c34, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c34
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c35.y
mad r1.y, -r1, c35.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c35, r1.y
mad r1.x, r1.z, c38, c38.y
mul r1.y, r0.w, c36.x
mov r1.z, c34.x
add_sat r0.y, r0, c35
mul_sat r0.x, r0, c31
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c30.x
mov r2.z, c34.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c34.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c38.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o9.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c38.z, c38.w
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
mad o3.xy, r5, c39.x, c39.y
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
mad o4.xy, r0, c39.x, c39.y
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
mov r0.w, c34.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c39.x, c39.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c39.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c39
mov r0.x, c33
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.w, r0, c23
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 165 instructions, 6 temp regs, 0 temp arrays:
// ALU 132 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjponillodkbacklkpbpkajnagknkgpaeabaaaaaahabiaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefchabgaaaa
eaaaabaajmafaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaa
apaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaa
adaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaa
egaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
bgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
afaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaaj
ecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaj
pcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaa
diaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaa
adaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaa
kgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaak
gcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaa
diaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaa
acaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaa
abaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
dbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaa
abaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaackaabaia
mbaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaa
dccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaah
iccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaag
ecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaa
aaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaa
agaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
adaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaa
kgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaa
acaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaa
abaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
aeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
acaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaa
adaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaa
fgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaa
dbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaa
aaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaa
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
kgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
egiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
ajaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaalaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaahaaaaaaegiocaaaaaaaaaaaamaaaaaapgapbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 387
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 485
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
#line 476
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
#line 378
uniform sampler2D _LightTextureB0;
#line 383
#line 397
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 410
#line 418
#line 432
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 465
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 469
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 473
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 499
#line 548
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 499
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 503
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 507
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 511
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 515
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 519
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 523
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 527
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 531
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 535
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 539
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 543
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
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
#line 387
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 485
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
#line 476
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
#line 378
uniform sampler2D _LightTextureB0;
#line 383
#line 397
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 410
#line 418
#line 432
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 465
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 469
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 473
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 499
#line 548
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 548
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 552
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 556
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 560
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 564
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DetailScale]
Float 31 [_DistFade]
Float 32 [_DistFadeVert]
Float 33 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 198 ALU, 4 TEX
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
def c34, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c35, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c36, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c37, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c38, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c39, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c32.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c38.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c36.y, c36
mad r3.z, r2, r3.y, c36.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c37.x
mad r1.w, r3.z, r3.y, c37.y
mad r3.y, r1.w, r3, c37.z
max r0.w, -r0, r0
slt r1.w, c34.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c35
add r3.x, -r0.w, c37.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c34.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c34, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c35.y
add r3.y, -r1.w, c35.w
mad r0.w, r1.z, c34.y, c34.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c34
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c35.x
slt r3.x, r1, c34
add r1.z, -r1, c35.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c34, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c34
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c35.y
mad r1.y, -r1, c35.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c35, r1.y
mad r1.x, r1.z, c38, c38.y
mul r1.y, r0.w, c36.x
mov r1.z, c34.x
add_sat r0.y, r0, c35
mul_sat r0.x, r0, c31
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c30.x
mov r2.z, c34.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c34.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c38.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o9.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c38.z, c38.w
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
mad o3.xy, r5, c39.x, c39.y
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
mad o4.xy, r0, c39.x, c39.y
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
mov r0.w, c34.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c39.x, c39.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c39.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c39
mov r0.x, c33
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 165 instructions, 6 temp regs, 0 temp arrays:
// ALU 132 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfeehfbnmkgndngahcnnocadebmikfecaabaaaaaahabiaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefchabgaaaa
eaaaabaajmafaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaa
apaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaa
adaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaa
egaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
bgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
afaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaaj
ecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaj
pcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaa
diaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaa
adaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaa
kgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaak
gcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaa
diaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaa
acaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaa
abaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
dbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaa
abaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaackaabaia
mbaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaa
dccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaah
iccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaag
ecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaa
aaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaa
agaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
adaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaa
kgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaa
acaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaa
abaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
aeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
acaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaa
adaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaa
fgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaa
dbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaa
aaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaa
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
kgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hccabaaaahaaaaaaegiccaaaaaaaaaaaamaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 379
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 477
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
#line 468
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
#line 378
uniform sampler2D _LightTextureB0;
#line 389
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 402
#line 410
#line 424
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 457
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 461
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 465
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 491
#line 540
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 491
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 495
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 499
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 503
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 507
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 511
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 515
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 519
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 523
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 527
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 531
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 535
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
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
#line 379
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 477
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
#line 468
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
#line 378
uniform sampler2D _LightTextureB0;
#line 389
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 402
#line 410
#line 424
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 457
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 461
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 465
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 491
#line 540
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 540
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 544
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 548
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 552
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 556
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DetailScale]
Float 31 [_DistFade]
Float 32 [_DistFadeVert]
Float 33 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 197 ALU, 4 TEX
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
def c34, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c35, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c36, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c37, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c38, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c39, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c32.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c38.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c36.y, c36
mad r3.z, r2, r3.y, c36.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c37.x
mad r1.w, r3.z, r3.y, c37.y
mad r3.y, r1.w, r3, c37.z
max r0.w, -r0, r0
slt r1.w, c34.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c35
add r3.x, -r0.w, c37.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c34.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c34, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c35.y
add r3.y, -r1.w, c35.w
mad r0.w, r1.z, c34.y, c34.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c34
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c35.x
slt r3.x, r1, c34
add r1.z, -r1, c35.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c34, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c34
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c35.y
mad r1.y, -r1, c35.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c35, r1.y
mad r1.x, r1.z, c38, c38.y
mul r1.y, r0.w, c36.x
mov r1.z, c34.x
add_sat r0.y, r0, c35
mul_sat r0.x, r0, c31
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c30.x
mov r2.z, c34.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c34.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c38.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o9.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c38.z, c38.w
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
mad o3.xy, r5, c39.x, c39.y
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
mad o4.xy, r0, c39.x, c39.y
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
mov r0.w, c34.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c39.x, c39.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c39.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c39
mov r0.x, c33
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 165 instructions, 6 temp regs, 0 temp arrays:
// ALU 132 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednkjnlpieclnmmbilmhgfipkhabkahaemabaaaaaahabiaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefchabgaaaa
eaaaabaajmafaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadmccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaa
apaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaa
adaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaa
egaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
bgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
afaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaaj
ecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaj
pcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaa
diaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaa
adaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaa
kgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaak
gcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaa
diaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaa
acaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaa
abaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
dbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaa
abaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaackaabaia
mbaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaa
dccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaah
iccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaag
ecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaa
aaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaa
agaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
adaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaa
kgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaa
acaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaa
abaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
aeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
acaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaa
adaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaa
fgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaa
dbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaa
aaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaidcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaakaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaa
egaabaaaacaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaalaaaaaa
kgakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaakmccabaaaaeaaaaaaagiecaaa
aaaaaaaaamaaaaaapgapbaaaabaaaaaaagaebaaaabaaaaaadcaaaaamhcaabaaa
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
aeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaahaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaahaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 378
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 476
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
#line 467
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
#line 388
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 401
#line 409
#line 423
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 456
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 460
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 464
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 490
#line 539
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 490
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 494
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 498
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 502
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 506
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 510
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 514
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 518
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 522
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 526
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 530
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 534
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
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
#line 378
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 476
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
#line 467
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
#line 388
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 401
#line 409
#line 423
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 456
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 460
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 464
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 490
#line 539
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 539
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 543
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 547
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 551
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 555
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 28 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 29 [_WorldSpaceCameraPos]
Vector 30 [_ProjectionParams]
Vector 31 [_ScreenParams]
Vector 32 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Matrix 24 [_LightMatrix0]
Vector 33 [_LightColor0]
Float 34 [_DetailScale]
Float 35 [_DistFade]
Float 36 [_DistFadeVert]
Float 37 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 203 ALU, 4 TEX
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
def c38, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c39, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c40, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c41, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c42, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c43, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
dp4 r1.w, r0, c19
add r0.xyz, -r0, c29
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c36.x
dp4 r2.z, -r1, c22
dp4 r2.x, -r1, c20
dp4 r2.y, -r1, c21
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c42.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c40.y, c40
mad r3.z, r2, r3.y, c40.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c41.x
mad r1.w, r3.z, r3.y, c41.y
mad r3.y, r1.w, r3, c41.z
max r0.w, -r0, r0
slt r1.w, c38.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c39
add r3.x, -r0.w, c41.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c38.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c38, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c39.y
add r3.y, -r1.w, c39.w
mad r0.w, r1.z, c38.y, c38.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c38
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c39.x
slt r3.x, r1, c38
add r1.z, -r1, c39.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c38, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c38
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c39.y
mad r1.y, -r1, c39.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c39, r1.y
mad r1.x, r1.z, c42, c42.y
mul r1.y, r0.w, c40.x
mov r1.z, c38.x
add_sat r0.y, r0, c39
mul_sat r0.x, r0, c35
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c34.x
mov r2.z, c38.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c38.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c42.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c30.x
mad o10.xy, r5.z, c31.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c42.z, c42.w
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
mad o3.xy, r5, c43.x, c43.y
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
mad o4.xy, r0, c43.x, c43.y
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
mov r0.w, c38.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c32, c32
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c29
mul r2.xyz, r0.w, c32
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c43.x, c43.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c43.z
mul r0.y, r0, c33.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c43
mov r0.x, c37
add r0.xyz, c33, r0.x
mad_sat o7.xyz, r0, r0.w, c28
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c27
dp4 o8.z, r0, c26
dp4 o8.y, r0, c25
dp4 o8.x, r0, c24
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 169 instructions, 6 temp regs, 0 temp arrays:
// ALU 136 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkldghgjnmaomfjpaeoefkeipibojbfcdabaaaaaadmbjaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefccebhaaaaeaaaabaamjafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaa
ajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaaacaaaaaafgifcaaaaeaaaaaaapaaaaaadcaaaaalpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaaaeaaaaaaapaaaaaaegaobaaa
acaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgikcaaa
aeaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaaeaaaaaapgipcaaaaeaaaaaaapaaaaaaegaobaaaacaaaaaadiaaaaaj
hcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaabgigcaaaaaaaaaaaagaaaaaa
dcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
ahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaajecaabaaaaaaaaaaackaabaia
ibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajpcaabaaaaeaaaaaafgaibaia
mbaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaadiaaaaahecaabaaaafaaaaaa
ckaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaaadaaaaaadgaaaaagdcaabaaa
afaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaajgahbaaa
abaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaakgcaabaaaabaaaaaakgajbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaaoaaaaahdcaabaaa
abaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaa
egaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaaeiaaaaalpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
baaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaaacaaaaaadeaaaaajecaabaaa
aaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaaoaaaaak
ecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
aaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
abeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaadaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabaaaaahbcaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadbaaaaaidcaabaaaadaaaaaa
jgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
dhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaa
keanmjdpaaaaaaaiecaabaaaacaaaaaackaabaiambaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaa
acaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaaeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
aeaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
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
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaaeaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaaeaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaaeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaa
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
afaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaalaaaaaa
kgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaa
aaaaaaaaamaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
aeaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 393
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 491
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
#line 482
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
#line 383
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 403
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 416
#line 424
#line 438
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 471
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 475
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 479
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 506
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 506
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 510
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 514
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 518
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 522
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 526
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 530
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 534
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 538
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 542
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 546
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 550
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 554
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
#line 393
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 491
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
#line 482
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
#line 383
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 403
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 416
#line 424
#line 438
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 471
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 475
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 479
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 506
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 556
lowp vec4 frag( in v2f i ) {
    #line 558
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 562
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 566
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 570
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 574
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 28 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 29 [_WorldSpaceCameraPos]
Vector 30 [_ProjectionParams]
Vector 31 [_ScreenParams]
Vector 32 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Matrix 24 [_LightMatrix0]
Vector 33 [_LightColor0]
Float 34 [_DetailScale]
Float 35 [_DistFade]
Float 36 [_DistFadeVert]
Float 37 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 203 ALU, 4 TEX
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
def c38, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c39, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c40, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c41, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c42, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c43, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
dp4 r1.w, r0, c19
add r0.xyz, -r0, c29
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c36.x
dp4 r2.z, -r1, c22
dp4 r2.x, -r1, c20
dp4 r2.y, -r1, c21
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c42.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c40.y, c40
mad r3.z, r2, r3.y, c40.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c41.x
mad r1.w, r3.z, r3.y, c41.y
mad r3.y, r1.w, r3, c41.z
max r0.w, -r0, r0
slt r1.w, c38.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c39
add r3.x, -r0.w, c41.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c38.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c38, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c39.y
add r3.y, -r1.w, c39.w
mad r0.w, r1.z, c38.y, c38.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c38
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c39.x
slt r3.x, r1, c38
add r1.z, -r1, c39.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c38, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c38
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c39.y
mad r1.y, -r1, c39.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c39, r1.y
mad r1.x, r1.z, c42, c42.y
mul r1.y, r0.w, c40.x
mov r1.z, c38.x
add_sat r0.y, r0, c39
mul_sat r0.x, r0, c35
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c34.x
mov r2.z, c38.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c38.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c42.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c30.x
mad o10.xy, r5.z, c31.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c42.z, c42.w
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
mad o3.xy, r5, c43.x, c43.y
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
mad o4.xy, r0, c43.x, c43.y
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
mov r0.w, c38.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c32, c32
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c29
mul r2.xyz, r0.w, c32
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c43.x, c43.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c43.z
mul r0.y, r0, c33.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c43
mov r0.x, c37
add r0.xyz, c33, r0.x
mad_sat o7.xyz, r0, r0.w, c28
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c27
dp4 o8.z, r0, c26
dp4 o8.y, r0, c25
dp4 o8.x, r0, c24
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 169 instructions, 6 temp regs, 0 temp arrays:
// ALU 136 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkldghgjnmaomfjpaeoefkeipibojbfcdabaaaaaadmbjaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefccebhaaaaeaaaabaamjafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaa
ajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaaacaaaaaafgifcaaaaeaaaaaaapaaaaaadcaaaaalpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaaaeaaaaaaapaaaaaaegaobaaa
acaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgikcaaa
aeaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaaeaaaaaapgipcaaaaeaaaaaaapaaaaaaegaobaaaacaaaaaadiaaaaaj
hcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaabgigcaaaaaaaaaaaagaaaaaa
dcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
ahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaajecaabaaaaaaaaaaackaabaia
ibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajpcaabaaaaeaaaaaafgaibaia
mbaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaadiaaaaahecaabaaaafaaaaaa
ckaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaaadaaaaaadgaaaaagdcaabaaa
afaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaajgahbaaa
abaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaakgcaabaaaabaaaaaakgajbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaaoaaaaahdcaabaaa
abaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaa
egaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaaeiaaaaalpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
baaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaaacaaaaaadeaaaaajecaabaaa
aaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaaoaaaaak
ecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
aaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
abeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaadaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabaaaaahbcaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadbaaaaaidcaabaaaadaaaaaa
jgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
dhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaa
keanmjdpaaaaaaaiecaabaaaacaaaaaackaabaiambaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaa
acaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabbaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabbaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaaeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
aeaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
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
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaaeaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaaeaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaaeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaa
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
afaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaalaaaaaa
kgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaa
aaaaaaaaamaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
aeaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 394
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 492
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
#line 483
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
#line 383
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 404
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 417
#line 425
#line 439
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 472
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 476
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 480
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 507
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 507
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 511
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 515
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 519
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 523
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 527
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 531
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 535
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 539
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 543
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 547
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 551
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 555
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
#line 394
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 492
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
#line 483
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
#line 383
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 404
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 417
#line 425
#line 439
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 472
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 476
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 480
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 507
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 557
lowp vec4 frag( in v2f i ) {
    #line 559
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 563
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 567
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 571
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 575
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_42;
  vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_5 * 0.5);
  vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_43.x;
  tmpvar_44.y = (tmpvar_43.y * _ProjectionParams.x);
  o_42.xy = (tmpvar_44 + tmpvar_43.w);
  o_42.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = o_42;
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Vector 25 [_LightColor0]
Float 26 [_DetailScale]
Float 27 [_DistFade]
Float 28 [_DistFadeVert]
Float 29 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 192 ALU, 4 TEX
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
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c28.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c34.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c32.y, c32
mad r3.z, r2, r3.y, c32.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c33.x
mad r1.w, r3.z, r3.y, c33.y
mad r3.y, r1.w, r3, c33.z
max r0.w, -r0, r0
slt r1.w, c30.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c31
add r3.x, -r0.w, c33.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c30.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c30, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c31.y
add r3.y, -r1.w, c31.w
mad r0.w, r1.z, c30.y, c30.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c30
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c31.x
slt r3.x, r1, c30
add r1.z, -r1, c31.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c30, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c30
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c31.y
mad r1.y, -r1, c31.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c31, r1.y
mad r1.x, r1.z, c34, c34.y
mul r1.y, r0.w, c32.x
mov r1.z, c30.x
texldl r1, r1.xyzz, s0
add_sat r0.y, r0, c31
mul_sat r0.x, r0, c27
mul r3.z, r0.x, r0.y
mul r2.xy, r2, c26.x
mov r2.z, c30.x
texldl r2, r2.xyzz, s1
mul r4, r1, r2
mov r1.xyz, c30.x
mov r1.w, v0
dp4 r5.y, r1, c1
dp4 r5.x, r1, c0
dp4 r5.w, r1, c3
dp4 r5.z, r1, c2
add r2, r5, v0
dp4 r0.w, r2, c7
mul o1.w, r4, r3.z
dp4 r3.y, r2, c5
dp4 r3.x, r2, c4
dp4 r3.z, r2, c6
mov r3.w, r0
mul r0.xyz, r3.xyww, c34.y
mul r0.y, r0, c22.x
mad r0.xy, r0.z, c23.zwzw, r0
dp4 r0.z, v0, c2
mov r0.z, -r0
mad r2.xy, v2, c34.z, c34.w
mov o9, r0
mov o8.xy, r0
dp3 r0.x, c2, c2
mov o0, r3
slt r0.z, r2.y, -r2.y
rsq r0.x, r0.x
mov o1.xyz, r4
mul r4.xyz, r0.x, c2
mov o8.zw, r3
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
mad o4.xy, r0, c35.x, c35.y
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
mov r0.w, c30.x
mad o3.xy, r3, c35.x, c35.y
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
mad o5.xy, r0, c35.x, c35.y
mul r0.xyz, r0.z, r3
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c35.z
mul r0.y, r0, c25.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c35
mov r0.x, c29
add r0.xyz, c25, r0.x
mad_sat o7.xyz, r0, r0.w, c20
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
Matrix 80 [_DetailRotation] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 159 instructions, 6 temp regs, 0 temp arrays:
// ALU 125 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmhjednjhiofhfgecpmkdkmdlcfoglamdabaaaaaahabhaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefchabfaaaa
eaaaabaafmafaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaaadaaaaaa
apaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaa
adaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaaapaaaaaa
egaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
bgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
afaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaacaaaaaaegacbaaaadaaaaaabnaaaaaj
icaabaaaacaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaj
pcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaadkaabaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaa
adaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaak
gcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaa
diaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
eiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaa
acaaaaaadeaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaaddaaaaajbcaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaa
acaaaaaadkaabaaaacaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaadaaaaaaakaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaadaaaaaa
akaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaah
ccaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ecaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaa
abaaaaahccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaa
abaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaddaaaaahbcaabaaa
adaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaibcaabaaaadaaaaaa
akaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaadaaaaaadhaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
acaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaackaabaia
mbaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaidpjkcdo
eiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaa
dccaaaalbcaabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
iccabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaag
ecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaa
bkaabaaaadaaaaaadbaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaaabeaaaaa
aaaaaaaaboaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
acaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
aeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaa
agaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
adaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaa
kgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaa
acaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaa
abaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
aeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
acaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaa
adaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaa
fgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaa
dbaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaai
ccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaadaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaa
bkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaa
abaaaaaangafbaaaacaaaaaaboaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaaccaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaackaabaaa
aeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaa
abaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaapgapbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
dkiacaaaaaaaaaaaanaaaaaadicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiaeaaaaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaanaaaaaa
pgipcaaaaaaaaaaabbaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaibcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdcaabaaa
aaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafpccabaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaaflccabaaaaiaaaaaaegambaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_64;
  tmpvar_64.x = tmpvar_63.x;
  tmpvar_64.y = (tmpvar_63.y * _ProjectionParams.x);
  o_62.xy = (tmpvar_64 + tmpvar_63.w);
  o_62.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = o_62;
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 384
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 482
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
#line 473
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
#line 378
#line 394
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 407
#line 415
#line 429
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 462
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 466
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 470
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 496
#line 545
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 496
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 500
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 504
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 508
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 512
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 516
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 520
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 524
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 528
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 532
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 536
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 540
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 384
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 482
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
#line 473
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
#line 378
#line 394
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 407
#line 415
#line 429
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 462
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 466
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 470
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 496
#line 545
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 545
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 549
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 553
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 557
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 561
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_42;
  vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_5 * 0.5);
  vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_43.x;
  tmpvar_44.y = (tmpvar_43.y * _ProjectionParams.x);
  o_42.xy = (tmpvar_44 + tmpvar_43.w);
  o_42.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD7 = o_42;
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 29 [_LightColor0]
Float 30 [_DetailScale]
Float 31 [_DistFade]
Float 32 [_DistFadeVert]
Float 33 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 198 ALU, 4 TEX
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
def c34, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c35, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c36, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c37, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c38, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c39, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c32.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c38.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c36.y, c36
mad r3.z, r2, r3.y, c36.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c37.x
mad r1.w, r3.z, r3.y, c37.y
mad r3.y, r1.w, r3, c37.z
max r0.w, -r0, r0
slt r1.w, c34.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c35
add r3.x, -r0.w, c37.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c34.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c34, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c35.y
add r3.y, -r1.w, c35.w
mad r0.w, r1.z, c34.y, c34.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c34
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c35.x
slt r3.x, r1, c34
add r1.z, -r1, c35.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c34, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c34
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c35.y
mad r1.y, -r1, c35.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c35, r1.y
mad r1.x, r1.z, c38, c38.y
mul r1.y, r0.w, c36.x
mov r1.z, c34.x
texldl r1, r1.xyzz, s0
add_sat r0.y, r0, c35
mul_sat r0.x, r0, c31
mul r3.z, r0.x, r0.y
mul r2.xy, r2, c30.x
mov r2.z, c34.x
texldl r2, r2.xyzz, s1
mul r4, r1, r2
mov r1.xyz, c34.x
mov r1.w, v0
dp4 r5.y, r1, c1
dp4 r5.x, r1, c0
dp4 r5.w, r1, c3
dp4 r5.z, r1, c2
add r2, r5, v0
dp4 r0.w, r2, c7
mul o1.w, r4, r3.z
dp4 r3.y, r2, c5
dp4 r3.x, r2, c4
dp4 r3.z, r2, c6
mov r3.w, r0
mul r0.xyz, r3.xyww, c38.y
mul r0.y, r0, c26.x
mad r0.xy, r0.z, c27.zwzw, r0
dp4 r0.z, v0, c2
mov r0.z, -r0
mad r2.xy, v2, c38.z, c38.w
mov o10, r0
mov o9.xy, r0
dp3 r0.x, c2, c2
mov o0, r3
slt r0.z, r2.y, -r2.y
rsq r0.x, r0.x
mov o1.xyz, r4
mul r4.xyz, r0.x, c2
mov o9.zw, r3
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
mad o4.xy, r0, c39.x, c39.y
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
mov r0.w, c34.x
mad o3.xy, r3, c39.x, c39.y
dp4 r3.z, r0, c10
dp4 r3.x, r0, c8
dp4 r3.y, r0, c9
dp3 r0.z, r3, r3
dp4 r0.w, c28, c28
dp4 r0.x, r2, c0
dp4 r0.y, r2, c1
add r0.xy, -r5, r0
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
add r1.xyz, -r2, c25
rsq r0.w, r0.w
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c39.x, c39.y
mul r0.xyz, r0.z, r3
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c39.z
mul r0.y, r0, c29.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c39
mov r0.x, c33
add r0.xyz, c29, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
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
Matrix 80 [_DetailRotation] 4
Matrix 208 [_LightMatrix0] 4
Vector 272 [_LightColor0] 4
Float 304 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 167 instructions, 6 temp regs, 0 temp arrays:
// ALU 133 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfoboepccejlndabgdpjmbhodgmdlenefabaaaaaamebiaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefckmbgaaaaeaaaabaaklafaaaa
fjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadmccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaa
adaaaaaaapaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
agiacaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaa
dcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaa
apaaaaaaegaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaabgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaa
aaaaaaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaal
hcaabaaaadaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaa
pgapbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaacaaaaaaegacbaaaadaaaaaa
bnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadp
aaaaaaajpcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaa
adaaaaaadiaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaadkaabaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaaaeaaaaaafgaebaia
ibaaaaaaadaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaa
aaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaa
abaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaa
diaaaaakgcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaa
bdaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaacaaaaaaigabbaia
ebaaaaaaacaaaaaadeaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaacaaaaaa
akaabaiaibaaaaaaacaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaddaaaaajbcaabaaaadaaaaaa
bkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaa
adaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaadaaaaaa
akaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaaj
bcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaadiphhpdp
diaaaaahccaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaa
acaaaaaaabaaaaahccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaanlapejma
aaaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaddaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaibcaabaaa
adaaaaaaakaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaadhaaaaakbcaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
icaabaaaacaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaa
ckaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeaabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaajecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
akaabaaaadaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
idpjkcdoeiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadccaaaalbcaabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabfaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaaacaaaaaabkaabaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
adaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaal
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
egbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaa
aaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaaaaboaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaacaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaapgapbaaaabaaaaaa
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
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaadaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaa
aaaaaaaabkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaa
fgafbaaaabaaaaaangafbaaaacaaaaaaboaaaaaiccaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaaccaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaacaaaaaaclaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaa
agaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaidcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaa
aoaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaanaaaaaaagaabaaa
abaaaaaaegaabaaaacaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaa
apaaaaaakgakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaakmccabaaaaeaaaaaa
agiecaaaaaaaaaaabaaaaaaapgapbaaaabaaaaaaagaebaaaabaaaaaadcaaaaam
hcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaafaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabbaaaaajicaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaabaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aknhcdlmdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaapnekibdp
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaabbaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
ocaabaaaabaaaaaaagijcaaaaaaaaaaabbaaaaaapgipcaaaaaaaaaaabfaaaaaa
dccaaaakhccabaaaagaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegiccaaa
aeaaaaaaaeaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadgaaaaafpccabaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaf
lccabaaaaiaaaaaaegambaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_64;
  tmpvar_64.x = tmpvar_63.x;
  tmpvar_64.y = (tmpvar_63.y * _ProjectionParams.x);
  o_62.xy = (tmpvar_64 + tmpvar_63.w);
  o_62.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = o_62;
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 386
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 484
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
#line 475
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
#line 378
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 396
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 409
#line 417
#line 431
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 464
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 468
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 472
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 499
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 499
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 503
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 507
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 511
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 515
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 519
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 523
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 527
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 531
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 535
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 539
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 543
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 547
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
#line 386
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 484
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
#line 475
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
#line 378
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 396
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 409
#line 417
#line 431
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 464
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 468
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 472
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 499
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 549
lowp vec4 frag( in v2f i ) {
    #line 551
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 555
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 559
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 563
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 567
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Vector 29 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 30 [_LightColor0]
Float 31 [_DetailScale]
Float 32 [_DistFade]
Float 33 [_DistFadeVert]
Float 34 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 199 ALU, 4 TEX
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
def c35, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c36, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c37, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c38, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c39, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c40, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c33.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c39.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c37.y, c37
mad r3.z, r2, r3.y, c37.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c38.x
mad r1.w, r3.z, r3.y, c38.y
mad r3.y, r1.w, r3, c38.z
max r0.w, -r0, r0
slt r1.w, c35.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c36
add r3.x, -r0.w, c38.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c35.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c35, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c36.y
add r3.y, -r1.w, c36.w
mad r0.w, r1.z, c35.y, c35.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c35
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c36.x
slt r3.x, r1, c35
add r1.z, -r1, c36.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c35, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c35
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c36.y
mad r1.y, -r1, c36.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c36, r1.y
mad r1.x, r1.z, c39, c39.y
mul r1.y, r0.w, c37.x
mov r1.z, c35.x
add_sat r0.y, r0, c36
mul_sat r0.x, r0, c32
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c31.x
mov r2.z, c35.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c35.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c39.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c39.z, c39.w
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
mad o3.xy, r5, c40.x, c40.y
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
mad o4.xy, r0, c40.x, c40.y
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
mov r0.w, c35.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c40.x, c40.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c40.z
mul r0.y, r0, c30.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c40
mov r0.x, c34
add r0.xyz, c30, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c29
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 167 instructions, 6 temp regs, 0 temp arrays:
// ALU 134 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednloobdmpklpgbonpplnnahgpppndokaeabaaaaaaoabiaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcmibgaaaaeaaaabaalcafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaa
adaaaaaaapaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
agiacaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaa
dcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaa
apaaaaaaegaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaabgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaa
aaaaaaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaal
hcaabaaaadaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaa
pgapbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
bnaaaaajecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaajpcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaa
adaaaaaadiaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaia
ibaaaaaaadaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaa
aaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaa
abaaaaaakgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaa
diaaaaakgcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaa
apaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaia
ebaaaaaaacaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaa
akaabaiaibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaa
bkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaa
adaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdp
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaa
acaaaaaaabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejma
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaah
icaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaa
ckaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaadcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaa
acaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjkcdoeiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
adaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaa
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
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
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
abaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
aiaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagaabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaa
amaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 391
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 489
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
#line 480
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
#line 389
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 401
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 414
#line 422
#line 436
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 469
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 473
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 477
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 504
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 504
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 508
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 512
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 516
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 520
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 524
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 528
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 532
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 536
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 540
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 544
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 548
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 552
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
#line 391
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 489
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
#line 480
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
#line 389
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 401
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 414
#line 422
#line 436
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 469
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 473
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 477
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 504
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 554
lowp vec4 frag( in v2f i ) {
    #line 556
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 560
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 564
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 568
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 572
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Vector 29 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 30 [_LightColor0]
Float 31 [_DetailScale]
Float 32 [_DistFade]
Float 33 [_DistFadeVert]
Float 34 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 199 ALU, 4 TEX
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
def c35, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c36, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c37, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c38, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c39, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c40, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c33.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c39.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c37.y, c37
mad r3.z, r2, r3.y, c37.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c38.x
mad r1.w, r3.z, r3.y, c38.y
mad r3.y, r1.w, r3, c38.z
max r0.w, -r0, r0
slt r1.w, c35.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c36
add r3.x, -r0.w, c38.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c35.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c35, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c36.y
add r3.y, -r1.w, c36.w
mad r0.w, r1.z, c35.y, c35.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c35
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c36.x
slt r3.x, r1, c35
add r1.z, -r1, c36.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c35, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c35
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c36.y
mad r1.y, -r1, c36.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c36, r1.y
mad r1.x, r1.z, c39, c39.y
mul r1.y, r0.w, c37.x
mov r1.z, c35.x
add_sat r0.y, r0, c36
mul_sat r0.x, r0, c32
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c31.x
mov r2.z, c35.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c35.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c39.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c39.z, c39.w
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
mad o3.xy, r5, c40.x, c40.y
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
mad o4.xy, r0, c40.x, c40.y
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
mov r0.w, c35.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c40.x, c40.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c40.z
mul r0.y, r0, c30.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c40
mov r0.x, c34
add r0.xyz, c30, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c29
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 167 instructions, 6 temp regs, 0 temp arrays:
// ALU 134 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednloobdmpklpgbonpplnnahgpppndokaeabaaaaaaoabiaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcmibgaaaaeaaaabaalcafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaa
adaaaaaaapaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
agiacaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaa
dcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaa
apaaaaaaegaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaabgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaa
aaaaaaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaal
hcaabaaaadaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaa
pgapbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
bnaaaaajecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaajpcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaa
adaaaaaadiaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaia
ibaaaaaaadaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaa
aaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaa
abaaaaaakgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaa
diaaaaakgcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaa
apaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaia
ebaaaaaaacaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaa
akaabaiaibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaa
bkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaa
adaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdp
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaa
acaaaaaaabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejma
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaah
icaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaa
ckaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaadcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaa
acaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjkcdoeiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
adaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaa
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
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
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
abaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
aiaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagaabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaa
amaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 392
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 490
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
#line 481
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
#line 389
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 402
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 415
#line 423
#line 437
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 470
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 474
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 478
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 505
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 505
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 509
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 513
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 517
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 521
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 525
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 529
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 533
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 537
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 541
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 545
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 549
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 553
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
#line 392
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 490
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
#line 481
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
#line 389
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 402
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 415
#line 423
#line 437
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 470
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 474
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 478
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 505
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 555
lowp vec4 frag( in v2f i ) {
    #line 557
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 561
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 565
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 569
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 573
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 28 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 29 [_WorldSpaceCameraPos]
Vector 30 [_ProjectionParams]
Vector 31 [_ScreenParams]
Vector 32 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Matrix 24 [_LightMatrix0]
Vector 33 [_LightColor0]
Float 34 [_DetailScale]
Float 35 [_DistFade]
Float 36 [_DistFadeVert]
Float 37 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 203 ALU, 4 TEX
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
def c38, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c39, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c40, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c41, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c42, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c43, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
dp4 r1.w, r0, c19
add r0.xyz, -r0, c29
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c36.x
dp4 r2.z, -r1, c22
dp4 r2.x, -r1, c20
dp4 r2.y, -r1, c21
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c42.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c40.y, c40
mad r3.z, r2, r3.y, c40.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c41.x
mad r1.w, r3.z, r3.y, c41.y
mad r3.y, r1.w, r3, c41.z
max r0.w, -r0, r0
slt r1.w, c38.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c39
add r3.x, -r0.w, c41.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c38.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c38, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c39.y
add r3.y, -r1.w, c39.w
mad r0.w, r1.z, c38.y, c38.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c38
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c39.x
slt r3.x, r1, c38
add r1.z, -r1, c39.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c38, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c38
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c39.y
mad r1.y, -r1, c39.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c39, r1.y
mad r1.x, r1.z, c42, c42.y
mul r1.y, r0.w, c40.x
mov r1.z, c38.x
add_sat r0.y, r0, c39
mul_sat r0.x, r0, c35
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c34.x
mov r2.z, c38.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c38.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c42.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c30.x
mad o10.xy, r5.z, c31.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c42.z, c42.w
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
mad o3.xy, r5, c43.x, c43.y
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
mad o4.xy, r0, c43.x, c43.y
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
mov r0.w, c38.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c32, c32
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c29
mul r2.xyz, r0.w, c32
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c43.x, c43.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c43.z
mul r0.y, r0, c33.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c43
mov r0.x, c37
add r0.xyz, c33, r0.x
mad_sat o7.xyz, r0, r0.w, c28
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c27
dp4 o8.z, r0, c26
dp4 o8.y, r0, c25
dp4 o8.x, r0, c24
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
Matrix 80 [_DetailRotation] 4
Matrix 208 [_LightMatrix0] 4
Vector 272 [_LightColor0] 4
Float 304 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 169 instructions, 6 temp regs, 0 temp arrays:
// ALU 136 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhgifoicngpandbajboempojhdeodnadgabaaaaaadmbjaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefccebhaaaaeaaaabaamjafaaaa
fjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaa
ajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaaacaaaaaafgifcaaaaeaaaaaaapaaaaaadcaaaaalpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaaaeaaaaaaapaaaaaaegaobaaa
acaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgikcaaa
aeaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaaeaaaaaapgipcaaaaeaaaaaaapaaaaaaegaobaaaacaaaaaadiaaaaaj
hcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaabgigcaaaaaaaaaaaagaaaaaa
dcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
ahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaajecaabaaaaaaaaaaackaabaia
ibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajpcaabaaaaeaaaaaafgaibaia
mbaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaadiaaaaahecaabaaaafaaaaaa
ckaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaaadaaaaaadgaaaaagdcaabaaa
afaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaajgahbaaa
abaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaakgcaabaaaabaaaaaakgajbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaaoaaaaahdcaabaaa
abaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaa
egaabaaaabaaaaaaagiacaaaaaaaaaaabdaaaaaaeiaaaaalpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
baaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaaacaaaaaadeaaaaajecaabaaa
aaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaaoaaaaak
ecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
aaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
abeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaadaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabaaaaahbcaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadbaaaaaidcaabaaaadaaaaaa
jgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
dhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaa
keanmjdpaaaaaaaiecaabaaaacaaaaaackaabaiambaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaa
acaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaaeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
aeaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
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
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaaeaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaaeaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaaeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabbaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaapgipcaaaaaaaaaaabfaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
afaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaaoaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaagaabaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaa
kgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaa
aaaaaaaabaaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
aeaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 401
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 499
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
#line 490
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
#line 378
#line 390
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 411
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 424
#line 432
#line 446
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 479
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 483
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 487
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 514
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 514
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 518
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 522
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 526
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 530
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 534
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 538
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 542
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 546
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 550
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 554
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 558
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 562
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
#line 401
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 499
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
#line 490
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
#line 378
#line 390
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 411
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 424
#line 432
#line 446
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 479
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 483
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 487
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 514
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 564
lowp vec4 frag( in v2f i ) {
    #line 566
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 570
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 574
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 578
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 582
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 28 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 29 [_WorldSpaceCameraPos]
Vector 30 [_ProjectionParams]
Vector 31 [_ScreenParams]
Vector 32 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Matrix 24 [_LightMatrix0]
Vector 33 [_LightColor0]
Float 34 [_DetailScale]
Float 35 [_DistFade]
Float 36 [_DistFadeVert]
Float 37 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 203 ALU, 4 TEX
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
def c38, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c39, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c40, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c41, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c42, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c43, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c15
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
dp4 r1.z, r0, c18
dp4 r1.x, r0, c16
dp4 r1.y, r0, c17
dp4 r1.w, r0, c19
add r0.xyz, -r0, c29
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c36.x
dp4 r2.z, -r1, c22
dp4 r2.x, -r1, c20
dp4 r2.y, -r1, c21
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c42.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c40.y, c40
mad r3.z, r2, r3.y, c40.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c41.x
mad r1.w, r3.z, r3.y, c41.y
mad r3.y, r1.w, r3, c41.z
max r0.w, -r0, r0
slt r1.w, c38.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c39
add r3.x, -r0.w, c41.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c38.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c38, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c39.y
add r3.y, -r1.w, c39.w
mad r0.w, r1.z, c38.y, c38.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c38
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c39.x
slt r3.x, r1, c38
add r1.z, -r1, c39.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c38, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c38
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c39.y
mad r1.y, -r1, c39.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c39, r1.y
mad r1.x, r1.z, c42, c42.y
mul r1.y, r0.w, c40.x
mov r1.z, c38.x
add_sat r0.y, r0, c39
mul_sat r0.x, r0, c35
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c34.x
mov r2.z, c38.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c38.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c42.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c30.x
mad o10.xy, r5.z, c31.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c42.z, c42.w
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
mad o3.xy, r5, c43.x, c43.y
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
mad o4.xy, r0, c43.x, c43.y
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
mov r0.w, c38.x
dp4 r5.z, r0, c14
dp4 r5.x, r0, c12
dp4 r5.y, r0, c13
dp3 r0.z, r5, r5
dp4 r0.w, c32, c32
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c14
dp4 r1.y, r2, c13
dp4 r1.x, r2, c12
rsq r0.w, r0.w
add r1.xyz, -r1, c29
mul r2.xyz, r0.w, c32
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c43.x, c43.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c43.z
mul r0.y, r0, c33.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c43
mov r0.x, c37
add r0.xyz, c33, r0.x
mad_sat o7.xyz, r0, r0.w, c28
dp4 r0.x, v0, c12
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
dp4 r0.y, v0, c13
dp4 o8.w, r0, c27
dp4 o8.z, r0, c26
dp4 o8.y, r0, c25
dp4 o8.x, r0, c24
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
Matrix 80 [_DetailRotation] 4
Matrix 208 [_LightMatrix0] 4
Vector 272 [_LightColor0] 4
Float 304 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 169 instructions, 6 temp regs, 0 temp arrays:
// ALU 136 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhgifoicngpandbajboempojhdeodnadgabaaaaaadmbjaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefccebhaaaaeaaaabaamjafaaaa
fjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaa
ajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaafaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaafaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaafaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaaacaaaaaafgifcaaaaeaaaaaaapaaaaaadcaaaaalpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagiacaaaaeaaaaaaapaaaaaaegaobaaa
acaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgikcaaa
aeaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaa
aaaaaaaaaeaaaaaapgipcaaaaeaaaaaaapaaaaaaegaobaaaacaaaaaadiaaaaaj
hcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaabgigcaaaaaaaaaaaagaaaaaa
dcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaa
ahaaaaaakgakbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaalhcaabaaa
adaaaaaabgigcaaaaaaaaaaaaiaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaabnaaaaajecaabaaaaaaaaaaackaabaia
ibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajpcaabaaaaeaaaaaafgaibaia
mbaaaaaaadaaaaaakgabbaiaibaaaaaaadaaaaaadiaaaaahecaabaaaafaaaaaa
ckaabaaaaaaaaaaadkaabaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaaeaaaaaafgaebaiaibaaaaaaadaaaaaadgaaaaagdcaabaaa
afaaaaaaegaabaiambaaaaaaadaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaafaaaaaabnaaaaaiecaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaiaibaaaaaaadaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaajgahbaaa
abaaaaaaegacbaiaibaaaaaaadaaaaaadiaaaaakgcaabaaaabaaaaaakgajbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaaoaaaaahdcaabaaa
abaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaa
egaabaaaabaaaaaaagiacaaaaaaaaaaabdaaaaaaeiaaaaalpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
baaaaaajecaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaakgakbaaaaaaaaaaaigabbaiaebaaaaaaacaaaaaadeaaaaajecaabaaa
aaaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaaoaaaaak
ecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
aaaaaaaaddaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
abeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaaadaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajccaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabaaaaahbcaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadbaaaaaidcaabaaaadaaaaaa
jgafbaaaacaaaaaajgafbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadbaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
dhaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaa
keanmjdpaaaaaaaiecaabaaaacaaaaaackaabaiambaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahicaabaaa
acaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoeiaaaaalpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaaeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
aeaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
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
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaaeaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaaeaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaaeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabbaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaapgipcaaaaaaaaaaabfaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
afaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaaoaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaagaabaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaa
kgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaa
aaaaaaaabaaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
aeaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaaeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 401
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 499
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
#line 490
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
#line 378
#line 390
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 411
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 424
#line 432
#line 446
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 479
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 483
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 487
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 514
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 514
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 518
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 522
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 526
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 530
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 534
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 538
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 542
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 546
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 550
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 554
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 558
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 562
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
#line 401
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 499
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
#line 490
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
#line 378
#line 390
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 411
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 424
#line 432
#line 446
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 479
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 483
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 487
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 514
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 564
lowp vec4 frag( in v2f i ) {
    #line 566
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 570
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 574
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 578
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 582
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Vector 29 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 30 [_LightColor0]
Float 31 [_DetailScale]
Float 32 [_DistFade]
Float 33 [_DistFadeVert]
Float 34 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 199 ALU, 4 TEX
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
def c35, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c36, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c37, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c38, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c39, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c40, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c33.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c39.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c37.y, c37
mad r3.z, r2, r3.y, c37.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c38.x
mad r1.w, r3.z, r3.y, c38.y
mad r3.y, r1.w, r3, c38.z
max r0.w, -r0, r0
slt r1.w, c35.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c36
add r3.x, -r0.w, c38.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c35.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c35, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c36.y
add r3.y, -r1.w, c36.w
mad r0.w, r1.z, c35.y, c35.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c35
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c36.x
slt r3.x, r1, c35
add r1.z, -r1, c36.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c35, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c35
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c36.y
mad r1.y, -r1, c36.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c36, r1.y
mad r1.x, r1.z, c39, c39.y
mul r1.y, r0.w, c37.x
mov r1.z, c35.x
add_sat r0.y, r0, c36
mul_sat r0.x, r0, c32
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c31.x
mov r2.z, c35.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c35.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c39.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c39.z, c39.w
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
mad o3.xy, r5, c40.x, c40.y
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
mad o4.xy, r0, c40.x, c40.y
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
mov r0.w, c35.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c40.x, c40.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c40.z
mul r0.y, r0, c30.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c40
mov r0.x, c34
add r0.xyz, c30, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c29
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 167 instructions, 6 temp regs, 0 temp arrays:
// ALU 134 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednloobdmpklpgbonpplnnahgpppndokaeabaaaaaaoabiaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcmibgaaaaeaaaabaalcafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaa
adaaaaaaapaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
agiacaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaa
dcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaa
apaaaaaaegaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaabgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaa
aaaaaaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaal
hcaabaaaadaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaa
pgapbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
bnaaaaajecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaajpcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaa
adaaaaaadiaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaia
ibaaaaaaadaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaa
aaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaa
abaaaaaakgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaa
diaaaaakgcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaa
apaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaia
ebaaaaaaacaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaa
akaabaiaibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaa
bkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaa
adaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdp
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaa
acaaaaaaabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejma
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaah
icaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaa
ckaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaadcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaa
acaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjkcdoeiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
adaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaa
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
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
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
abaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
aiaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagaabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaa
amaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 397
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 495
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
#line 486
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
#line 396
uniform highp mat4 _LightMatrix0;
#line 407
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 420
#line 428
#line 442
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 475
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 479
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 483
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 510
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 510
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 514
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 518
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 522
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 526
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 530
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 534
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 538
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 542
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 546
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 550
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 554
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 558
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
#line 397
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 495
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
#line 486
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
#line 396
uniform highp mat4 _LightMatrix0;
#line 407
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 420
#line 428
#line 442
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 475
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 479
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 483
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 510
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 560
lowp vec4 frag( in v2f i ) {
    #line 562
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 566
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 570
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 574
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 578
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
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform mat4 _LightMatrix0;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 detail_pos_1;
  vec4 XYv_2;
  vec4 XZv_3;
  vec4 ZYv_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = gl_Vertex.w;
  vec4 tmpvar_15;
  tmpvar_15 = (gl_ModelViewMatrix * tmpvar_14);
  tmpvar_5 = (gl_ProjectionMatrix * (tmpvar_15 + gl_Vertex));
  vec4 v_16;
  v_16.x = gl_ModelViewMatrix[0].z;
  v_16.y = gl_ModelViewMatrix[1].z;
  v_16.z = gl_ModelViewMatrix[2].z;
  v_16.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(v_16.xyz);
  tmpvar_7 = abs(tmpvar_17);
  vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_18.w = gl_Vertex.w;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_18).xyz));
  vec2 tmpvar_19;
  tmpvar_19 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_20;
  tmpvar_20.z = 0.0;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = tmpvar_19.y;
  tmpvar_20.w = gl_Vertex.w;
  ZYv_4.xyw = tmpvar_20.zyw;
  XZv_3.yzw = tmpvar_20.zyw;
  XYv_2.yzw = tmpvar_20.yzw;
  ZYv_4.z = (tmpvar_19.x * sign(-(tmpvar_17.x)));
  XZv_3.x = (tmpvar_19.x * sign(-(tmpvar_17.y)));
  XYv_2.x = (tmpvar_19.x * sign(tmpvar_17.z));
  ZYv_4.x = ((sign(-(tmpvar_17.x)) * sign(ZYv_4.z)) * tmpvar_17.z);
  XZv_3.y = ((sign(-(tmpvar_17.y)) * sign(XZv_3.x)) * tmpvar_17.x);
  XYv_2.z = ((sign(-(tmpvar_17.z)) * sign(XYv_2.x)) * tmpvar_17.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_17.x)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_17.y)) * sign(tmpvar_19.y)) * tmpvar_17.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_17.z)) * sign(tmpvar_19.y)) * tmpvar_17.y));
  tmpvar_8 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_4).xy - tmpvar_15.xy)));
  tmpvar_9 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_3).xy - tmpvar_15.xy)));
  tmpvar_10 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_2).xy - tmpvar_15.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = gl_Normal;
  tmpvar_12 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_22).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  vec4 tmpvar_23;
  tmpvar_23 = -((_MainRotation * tmpvar_21));
  detail_pos_1 = (_DetailRotation * tmpvar_23).xyz;
  vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  vec2 uv_25;
  float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    float s_28;
    float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  vec4 uv_30;
  vec3 tmpvar_31;
  tmpvar_31 = abs(normalize(detail_pos_1));
  float tmpvar_32;
  tmpvar_32 = float((tmpvar_31.z >= tmpvar_31.x));
  vec3 tmpvar_33;
  tmpvar_33 = mix (tmpvar_31.yxz, mix (tmpvar_31, tmpvar_31.zxy, vec3(tmpvar_32)), vec3(float((mix (tmpvar_31.x, tmpvar_31.z, tmpvar_32) >= tmpvar_31.y))));
  uv_30.xy = (((0.5 * tmpvar_33.zy) / abs(tmpvar_33.x)) * _DetailScale);
  uv_30.zw = vec2(0.0, 0.0);
  vec4 tmpvar_34;
  tmpvar_34 = (texture2DLod (_MainTex, uv_25, 0.0) * texture2DLod (_DetailTex, uv_30.xy, 0.0));
  tmpvar_6.xyz = tmpvar_34.xyz;
  vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  vec4 p_36;
  p_36 = (tmpvar_21 - tmpvar_35);
  vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = _WorldSpaceCameraPos;
  vec4 p_38;
  p_38 = (tmpvar_21 - tmpvar_37);
  tmpvar_6.w = (tmpvar_34.w * (clamp ((_DistFade * sqrt(dot (p_36, p_36))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_38, p_38)))), 0.0, 1.0)));
  vec4 o_39;
  vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_5 * 0.5);
  vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_5.zw;
  tmpvar_13.xyw = o_39.xyw;
  tmpvar_13.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_13;
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
Vector 24 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 25 [_WorldSpaceCameraPos]
Vector 26 [_ProjectionParams]
Vector 27 [_ScreenParams]
Vector 28 [_WorldSpaceLightPos0]
Vector 29 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_MainRotation]
Matrix 16 [_DetailRotation]
Matrix 20 [_LightMatrix0]
Vector 30 [_LightColor0]
Float 31 [_DetailScale]
Float 32 [_DistFade]
Float 33 [_DistFadeVert]
Float 34 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 199 ALU, 4 TEX
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
def c35, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c36, 1.57072902, 1.00000000, 2.00000000, 3.14159298
def c37, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c38, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c39, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c40, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_2d s0
dcl_2d s1
mov r0.w, c11
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
dp4 r1.z, r0, c14
dp4 r1.x, r0, c12
dp4 r1.y, r0, c13
dp4 r1.w, r0, c15
add r0.xyz, -r0, c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c33.x
dp4 r2.z, -r1, c18
dp4 r2.x, -r1, c16
dp4 r2.y, -r1, c17
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r2.xyz, r0.w, r2
abs r2.xyz, r2
sge r0.w, r2.z, r2.x
add r3.xyz, r2.zxyw, -r2
mad r3.xyz, r0.w, r3, r2
sge r1.w, r3.x, r2.y
add r3.xyz, r3, -r2.yxzw
mad r2.xyz, r1.w, r3, r2.yxzw
dp3 r0.w, -r1, -r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, -r1
mul r2.zw, r2.xyzy, c39.y
abs r1.w, r1.z
abs r0.w, r1.x
max r2.y, r1.w, r0.w
abs r3.y, r2.x
min r2.x, r1.w, r0.w
rcp r2.y, r2.y
mul r3.x, r2, r2.y
rcp r2.x, r3.y
mul r2.xy, r2.zwzw, r2.x
mul r3.y, r3.x, r3.x
mad r2.z, r3.y, c37.y, c37
mad r3.z, r2, r3.y, c37.w
slt r0.w, r1, r0
mad r3.z, r3, r3.y, c38.x
mad r1.w, r3.z, r3.y, c38.y
mad r3.y, r1.w, r3, c38.z
max r0.w, -r0, r0
slt r1.w, c35.x, r0
mul r0.w, r3.y, r3.x
add r3.y, -r1.w, c36
add r3.x, -r0.w, c38.w
mul r3.y, r0.w, r3
slt r0.w, r1.z, c35.x
mad r1.w, r1, r3.x, r3.y
max r0.w, -r0, r0
slt r3.x, c35, r0.w
abs r1.z, r1.y
add r3.z, -r3.x, c36.y
add r3.y, -r1.w, c36.w
mad r0.w, r1.z, c35.y, c35.z
mul r3.z, r1.w, r3
mad r1.w, r0, r1.z, c35
mad r0.w, r3.x, r3.y, r3.z
mad r1.w, r1, r1.z, c36.x
slt r3.x, r1, c35
add r1.z, -r1, c36.y
rsq r1.x, r1.z
max r1.z, -r3.x, r3.x
slt r3.x, c35, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c35
mul r1.y, r1.x, r1.z
add r1.w, -r3.x, c36.y
mad r1.y, -r1, c36.z, r1.z
mul r1.w, r0, r1
mad r1.z, r3.x, -r0.w, r1.w
mad r0.w, r1.x, c36, r1.y
mad r1.x, r1.z, c39, c39.y
mul r1.y, r0.w, c37.x
mov r1.z, c35.x
add_sat r0.y, r0, c36
mul_sat r0.x, r0, c32
mul r0.x, r0, r0.y
dp3 r0.z, c2, c2
mul r2.xy, r2, c31.x
mov r2.z, c35.x
texldl r2, r2.xyzz, s1
texldl r1, r1.xyzz, s0
mul r1, r1, r2
mov r2.xyz, c35.x
mov r2.w, v0
dp4 r4.y, r2, c1
dp4 r4.x, r2, c0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r3, r4, v0
dp4 r4.z, r3, c7
mul o1.w, r1, r0.x
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r4.z
mul r5.xyz, r0.xyww, c39.y
mov o1.xyz, r1
mov r1.x, r5
mul r1.y, r5, c26.x
mad o10.xy, r5.z, c27.zwzw, r1
rsq r1.x, r0.z
dp4 r0.z, r3, c6
mul r3.xyz, r1.x, c2
mov o0, r0
mad r1.xy, v2, c39.z, c39.w
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
mad o3.xy, r5, c40.x, c40.y
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
mad o4.xy, r0, c40.x, c40.y
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
mov r0.w, c35.x
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
dp3 r0.z, r5, r5
dp4 r0.w, c28, c28
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r4, r0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
rsq r0.w, r0.w
add r1.xyz, -r1, c25
mul r2.xyz, r0.w, c28
dp3 r0.w, r1, r1
rsq r0.z, r0.z
mad o5.xy, r0, c40.x, c40.y
mul r0.xyz, r0.z, r5
dp3_sat r0.y, r0, r2
rsq r0.x, r0.w
add r0.y, r0, c40.z
mul r0.y, r0, c30.w
mul o6.xyz, r0.x, r1
mul_sat r0.w, r0.y, c40
mov r0.x, c34
add r0.xyz, c30, r0.x
mad_sat o7.xyz, r0, r0.w, c24
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c22
dp4 o8.y, r0, c21
dp4 o8.x, r0, c20
dp4 r0.w, v0, c2
mov o10.w, r4.z
abs o2.xyz, r3
add o9.xyz, r0, -c29
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
Matrix 80 [_DetailRotation] 4
Matrix 144 [_LightMatrix0] 4
Vector 208 [_LightColor0] 4
Float 240 [_DetailScale]
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
SetTexture 1 [_DetailTex] 2D 1
// 167 instructions, 6 temp regs, 0 temp arrays:
// ALU 134 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednloobdmpklpgbonpplnnahgpppndokaeabaaaaaaoabiaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcmibgaaaaeaaaabaalcafaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaafgifcaaa
adaaaaaaapaaaaaadcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
agiacaaaadaaaaaaapaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgikcaaaadaaaaaaapaaaaaaegaobaaaacaaaaaa
dcaaaaalpcaabaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaapgipcaaaadaaaaaa
apaaaaaaegaobaaaacaaaaaadiaaaaajhcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaabgigcaaaaaaaaaaaagaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaa
aaaaaaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaal
hcaabaaaadaaaaaabgigcaaaaaaaaaaaahaaaaaakgakbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaalhcaabaaaadaaaaaabgigcaaaaaaaaaaaaiaaaaaa
pgapbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
bnaaaaajecaabaaaaaaaaaaackaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaajpcaabaaaaeaaaaaafgaibaiambaaaaaaadaaaaaakgabbaiaibaaaaaa
adaaaaaadiaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaafgaebaia
ibaaaaaaadaaaaaadgaaaaagdcaabaaaafaaaaaaegaabaiambaaaaaaadaaaaaa
aaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaafaaaaaabnaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaa
abaaaaaakgakbaaaaaaaaaaajgahbaaaabaaaaaaegacbaiaibaaaaaaadaaaaaa
diaaaaakgcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaagiacaaaaaaaaaaa
apaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaajecaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaigabbaia
ebaaaaaaacaaaaaadeaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaa
akaabaiaibaaaaaaacaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaajicaabaaaacaaaaaa
bkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaaacaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaa
adaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdp
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajccaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaakaabaiaibaaaaaa
acaaaaaaabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadbaaaaaidcaabaaaadaaaaaajgafbaaaacaaaaaajgafbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaanlapejma
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaddaaaaah
icaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadhaaaaakecaabaaaaaaaaaaaakaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaacaaaaaa
ckaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaadcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeaabaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaa
acaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaa
idpjkcdoeiaaaaalpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaibcaabaaaacaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
adaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaa
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
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaa
dcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
jkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaai
kcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
gcaabaaaadaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaa
acaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
abaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaa
kgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
ckaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaa
kgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaa
abaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
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
abaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
aiaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagaabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaa
amaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaajaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _DetailRotation;
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
  highp vec3 detail_pos_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  highp vec4 XYv_5;
  highp vec4 XZv_6;
  highp vec4 ZYv_7;
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  highp vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = _glesVertex.w;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_modelview0 * tmpvar_17);
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_18 + _glesVertex));
  vec4 v_19;
  v_19.x = glstate_matrix_modelview0[0].z;
  v_19.y = glstate_matrix_modelview0[1].z;
  v_19.z = glstate_matrix_modelview0[2].z;
  v_19.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(v_19.xyz);
  tmpvar_10 = abs(tmpvar_20);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = _glesVertex.w;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_21).xyz));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = tmpvar_22.y;
  tmpvar_23.w = _glesVertex.w;
  ZYv_7.xyw = tmpvar_23.zyw;
  XZv_6.yzw = tmpvar_23.zyw;
  XYv_5.yzw = tmpvar_23.yzw;
  ZYv_7.z = (tmpvar_22.x * sign(-(tmpvar_20.x)));
  XZv_6.x = (tmpvar_22.x * sign(-(tmpvar_20.y)));
  XYv_5.x = (tmpvar_22.x * sign(tmpvar_20.z));
  ZYv_7.x = ((sign(-(tmpvar_20.x)) * sign(ZYv_7.z)) * tmpvar_20.z);
  XZv_6.y = ((sign(-(tmpvar_20.y)) * sign(XZv_6.x)) * tmpvar_20.x);
  XYv_5.z = ((sign(-(tmpvar_20.z)) * sign(XYv_5.x)) * tmpvar_20.x);
  ZYv_7.x = (ZYv_7.x + ((sign(-(tmpvar_20.x)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  XZv_6.y = (XZv_6.y + ((sign(-(tmpvar_20.y)) * sign(tmpvar_22.y)) * tmpvar_20.z));
  XYv_5.z = (XYv_5.z + ((sign(-(tmpvar_20.z)) * sign(tmpvar_22.y)) * tmpvar_20.y));
  tmpvar_11 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_7).xy - tmpvar_18.xy)));
  tmpvar_12 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_6).xy - tmpvar_18.xy)));
  tmpvar_13 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_5).xy - tmpvar_18.xy)));
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_26;
  tmpvar_26 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (normalize((_Object2World * tmpvar_25).xyz), lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_29)), 0.0, 1.0);
  tmpvar_15 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = -((_MainRotation * tmpvar_24));
  detail_pos_1 = (_DetailRotation * tmpvar_31).xyz;
  mediump vec4 tex_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(tmpvar_31.xyz);
  highp vec2 uv_34;
  highp float r_35;
  if ((abs(tmpvar_33.z) > (1e-08 * abs(tmpvar_33.x)))) {
    highp float y_over_x_36;
    y_over_x_36 = (tmpvar_33.x / tmpvar_33.z);
    highp float s_37;
    highp float x_38;
    x_38 = (y_over_x_36 * inversesqrt(((y_over_x_36 * y_over_x_36) + 1.0)));
    s_37 = (sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296)))))))));
    r_35 = s_37;
    if ((tmpvar_33.z < 0.0)) {
      if ((tmpvar_33.x >= 0.0)) {
        r_35 = (s_37 + 3.14159);
      } else {
        r_35 = (r_35 - 3.14159);
      };
    };
  } else {
    r_35 = (sign(tmpvar_33.x) * 1.5708);
  };
  uv_34.x = (0.5 + (0.159155 * r_35));
  uv_34.y = (0.31831 * (1.5708 - (sign(tmpvar_33.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_33.y))) * (1.5708 + (abs(tmpvar_33.y) * (-0.214602 + (abs(tmpvar_33.y) * (0.0865667 + (abs(tmpvar_33.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLod (_MainTex, uv_34, 0.0);
  tex_32 = tmpvar_39;
  tmpvar_9 = tex_32;
  mediump vec4 tmpvar_40;
  highp vec4 uv_41;
  mediump vec3 detailCoords_42;
  mediump float nylerp_43;
  mediump float zxlerp_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = abs(normalize(detail_pos_1));
  highp float tmpvar_46;
  tmpvar_46 = float((tmpvar_45.z >= tmpvar_45.x));
  zxlerp_44 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = float((mix (tmpvar_45.x, tmpvar_45.z, zxlerp_44) >= tmpvar_45.y));
  nylerp_43 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = mix (tmpvar_45, tmpvar_45.zxy, vec3(zxlerp_44));
  detailCoords_42 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (tmpvar_45.yxz, detailCoords_42, vec3(nylerp_43));
  detailCoords_42 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = abs(detailCoords_42.x);
  uv_41.xy = (((0.5 * detailCoords_42.zy) / tmpvar_50) * _DetailScale);
  uv_41.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLod (_DetailTex, uv_41.xy, 0.0);
  tmpvar_40 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_9 * tmpvar_40);
  tmpvar_9 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = _WorldSpaceCameraPos;
  highp vec4 p_54;
  p_54 = (tmpvar_24 - tmpvar_53);
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  highp vec4 p_56;
  p_56 = (tmpvar_24 - tmpvar_55);
  highp float tmpvar_57;
  tmpvar_57 = clamp ((_DistFade * sqrt(dot (p_54, p_54))), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_56, p_56)))), 0.0, 1.0);
  tmpvar_9.w = (tmpvar_9.w * (tmpvar_57 * tmpvar_58));
  highp vec4 o_59;
  highp vec4 tmpvar_60;
  tmpvar_60 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_61;
  tmpvar_61.x = tmpvar_60.x;
  tmpvar_61.y = (tmpvar_60.y * _ProjectionParams.x);
  o_59.xy = (tmpvar_61 + tmpvar_60.w);
  o_59.zw = tmpvar_8.zw;
  tmpvar_16.xyw = o_59.xyw;
  tmpvar_16.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = tmpvar_14;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_16;
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
#line 398
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 496
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
#line 487
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
#line 396
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 408
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 421
#line 429
#line 443
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 476
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 480
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 484
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 511
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 351
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 353
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    #line 357
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    #line 361
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
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
#line 511
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 515
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 519
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 523
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 527
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 531
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 535
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 539
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 543
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 547
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    #line 551
    highp float dist = (_DistFade * distance( origin, vec4( _WorldSpaceCameraPos, 0.0)));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, vec4( _WorldSpaceCameraPos, 0.0))));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    o.projPos = ComputeScreenPos( o.pos);
    #line 555
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 559
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
#line 398
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 496
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
#line 487
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
#line 396
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 408
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 421
#line 429
#line 443
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
#line 476
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 480
uniform lowp vec4 _Color;
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 484
uniform highp float _MinLight;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 511
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 561
lowp vec4 frag( in v2f i ) {
    #line 563
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 567
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 571
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 575
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 579
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

#LINE 192
 
		}
		
	} 
	
}
}