Shader "EVE/CloudVolumeParticle" {
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
	_Rotation ("Rotation", float) = 0
	_MaxScale ("Max Scale", float) = 1
	_MaxTrans ("Max Translation", Vector) = (0,0,0)
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
// Vertex combos: 12
//   d3d9 - ALU: 358 to 358, TEX: 4 to 4
//   d3d11 - ALU: 225 to 225, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256 // 252 used size, 15 vars
Vector 16 [_LightColor0] 4
Matrix 48 [_MainRotation] 4
Matrix 112 [_DetailRotation] 4
Float 176 [_DetailScale]
Float 208 [_DistFade]
Float 212 [_DistFadeVert]
Float 228 [_Rotation]
Float 232 [_MaxScale]
Vector 240 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkddpfknkfpelnjmhdbajgcjihmbfgpjdabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aeaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
afaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaagaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaaiaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaahaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaajaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
akaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaalaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaanaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
aoaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 456
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 460
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 431
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 435
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 439
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 406
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 410
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 414
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 418
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 472
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 476
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 480
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 484
    return c;
}
#line 486
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 488
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 393
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 529
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 533
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 537
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 541
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 545
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 549
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 553
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 557
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 561
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 565
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 569
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 573
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 577
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 581
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 585
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 589
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 593
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 596
lowp vec4 frag( in v2f IN ) {
    #line 598
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 602
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 606
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 610
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 614
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256 // 252 used size, 15 vars
Vector 16 [_LightColor0] 4
Matrix 48 [_MainRotation] 4
Matrix 112 [_DetailRotation] 4
Float 176 [_DetailScale]
Float 208 [_DistFade]
Float 212 [_DistFadeVert]
Float 228 [_Rotation]
Float 232 [_MaxScale]
Vector 240 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkddpfknkfpelnjmhdbajgcjihmbfgpjdabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aeaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
afaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaagaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaaiaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaahaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaajaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
akaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaalaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaanaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
aoaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 456
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 460
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 431
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 435
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 439
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 406
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 410
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 414
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 418
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 472
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 476
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 480
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 484
    return c;
}
#line 486
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 488
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 393
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 529
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 533
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 537
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 541
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 545
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 549
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 553
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 557
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 561
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 565
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 569
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 573
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 577
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 581
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 585
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 589
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 593
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 596
lowp vec4 frag( in v2f IN ) {
    #line 598
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 602
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 606
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 610
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 614
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256 // 252 used size, 15 vars
Vector 16 [_LightColor0] 4
Matrix 48 [_MainRotation] 4
Matrix 112 [_DetailRotation] 4
Float 176 [_DetailScale]
Float 208 [_DistFade]
Float 212 [_DistFadeVert]
Float 228 [_Rotation]
Float 232 [_MaxScale]
Vector 240 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkddpfknkfpelnjmhdbajgcjihmbfgpjdabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aeaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
afaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaagaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaaiaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaahaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaajaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
akaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaalaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaanaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
aoaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 456
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 460
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 431
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 435
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 439
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 406
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 410
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 414
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 418
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 472
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 476
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 480
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 484
    return c;
}
#line 486
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 488
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 393
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 529
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 533
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 537
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 541
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 545
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 549
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 553
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 557
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 561
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 565
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 569
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 573
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 577
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 581
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 585
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 589
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 593
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 596
lowp vec4 frag( in v2f IN ) {
    #line 598
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 602
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 606
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 610
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 614
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 320 // 316 used size, 16 vars
Vector 80 [_LightColor0] 4
Matrix 112 [_MainRotation] 4
Matrix 176 [_DetailRotation] 4
Float 240 [_DetailScale]
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 292 [_Rotation]
Float 296 [_MaxScale]
Vector 304 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedinmljikmaidcgbficcikcnpmcnobkmleabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
bcaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aiaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaahaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
ajaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaakaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaamaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaalaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaanaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
aoaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaapaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaafaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
bcaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 320 // 316 used size, 16 vars
Vector 80 [_LightColor0] 4
Matrix 112 [_MainRotation] 4
Matrix 176 [_DetailRotation] 4
Float 240 [_DetailScale]
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 292 [_Rotation]
Float 296 [_MaxScale]
Vector 304 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedinmljikmaidcgbficcikcnpmcnobkmleabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
bcaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aiaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaahaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
ajaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaakaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaamaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaalaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaanaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
aoaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaapaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaafaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
bcaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 320 // 316 used size, 16 vars
Vector 80 [_LightColor0] 4
Matrix 112 [_MainRotation] 4
Matrix 176 [_DetailRotation] 4
Float 240 [_DetailScale]
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 292 [_Rotation]
Float 296 [_MaxScale]
Vector 304 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedinmljikmaidcgbficcikcnpmcnobkmleabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
bcaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aiaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaahaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
ajaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaakaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaamaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaalaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaanaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
aoaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaapaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaafaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
bcaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256 // 252 used size, 15 vars
Vector 16 [_LightColor0] 4
Matrix 48 [_MainRotation] 4
Matrix 112 [_DetailRotation] 4
Float 176 [_DetailScale]
Float 208 [_DistFade]
Float 212 [_DistFadeVert]
Float 228 [_Rotation]
Float 232 [_MaxScale]
Vector 240 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkddpfknkfpelnjmhdbajgcjihmbfgpjdabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aeaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
afaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaagaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaaiaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaahaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaajaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
akaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaalaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaanaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
aoaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 456
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 460
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 431
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 435
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 439
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 406
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 410
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 414
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 418
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 472
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 476
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 480
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 484
    return c;
}
#line 486
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 488
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 393
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 529
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 533
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 537
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 541
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 545
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 549
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 553
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 557
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 561
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 565
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 569
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 573
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 577
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 581
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 585
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 589
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 593
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 518
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 509
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 397
#line 406
#line 414
#line 423
#line 431
#line 444
#line 456
#line 472
#line 493
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 497
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 501
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 505
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 529
#line 545
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 596
lowp vec4 frag( in v2f IN ) {
    #line 598
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 602
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 606
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 610
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 614
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec3 _MaxTrans;
uniform float _MaxScale;
uniform float _Rotation;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;

uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec3 detail_pos_4;
  float localScale_5;
  vec4 localOrigin_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_6.xyz = (((2.0 * tmpvar_9) - 1.0) * _MaxTrans);
  localOrigin_6.w = 1.0;
  localScale_5 = ((tmpvar_9.x * (_MaxScale - 1.0)) + 1.0);
  vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * localOrigin_6);
  vec4 tmpvar_11;
  tmpvar_11 = -((_MainRotation * tmpvar_10));
  detail_pos_4 = (_DetailRotation * tmpvar_11).xyz;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11.xyz);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec4 uv_18;
  vec3 tmpvar_19;
  tmpvar_19 = abs(normalize(detail_pos_4));
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20) >= tmpvar_19.y))));
  uv_18.xy = (((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x)) * _DetailScale);
  uv_18.zw = vec2(0.0, 0.0);
  vec4 tmpvar_22;
  tmpvar_22 = (texture2DLod (_MainTex, uv_13, 0.0) * texture2DLod (_DetailTex, uv_18.xy, 0.0));
  vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  float tmpvar_24;
  vec4 p_25;
  p_25 = (tmpvar_10 - tmpvar_23);
  tmpvar_24 = sqrt(dot (p_25, p_25));
  tmpvar_7.w = (tmpvar_22.w * (clamp ((_DistFade * tmpvar_24), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_24)), 0.0, 1.0)));
  vec3 tmpvar_26;
  tmpvar_26.yz = vec2(0.0, 0.0);
  tmpvar_26.x = fract(_Rotation);
  vec3 x_27;
  x_27 = (tmpvar_26 + tmpvar_9);
  vec3 trans_28;
  trans_28 = localOrigin_6.xyz;
  float tmpvar_29;
  tmpvar_29 = (x_27.x * 6.28319);
  float tmpvar_30;
  tmpvar_30 = (x_27.y * 6.28319);
  float tmpvar_31;
  tmpvar_31 = (x_27.z * 2.0);
  float tmpvar_32;
  tmpvar_32 = sqrt(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (sin(tmpvar_30) * tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (cos(tmpvar_30) * tmpvar_32);
  float tmpvar_35;
  tmpvar_35 = sqrt((2.0 - tmpvar_31));
  float tmpvar_36;
  tmpvar_36 = sin(tmpvar_29);
  float tmpvar_37;
  tmpvar_37 = cos(tmpvar_29);
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_33 * tmpvar_37) - (tmpvar_34 * tmpvar_36));
  float tmpvar_39;
  tmpvar_39 = ((tmpvar_33 * tmpvar_36) + (tmpvar_34 * tmpvar_37));
  mat4 tmpvar_40;
  tmpvar_40[0].x = (localScale_5 * ((tmpvar_33 * tmpvar_38) - tmpvar_37));
  tmpvar_40[0].y = ((tmpvar_33 * tmpvar_39) - tmpvar_36);
  tmpvar_40[0].z = (tmpvar_33 * tmpvar_35);
  tmpvar_40[0].w = 0.0;
  tmpvar_40[1].x = ((tmpvar_34 * tmpvar_38) + tmpvar_36);
  tmpvar_40[1].y = (localScale_5 * ((tmpvar_34 * tmpvar_39) - tmpvar_37));
  tmpvar_40[1].z = (tmpvar_34 * tmpvar_35);
  tmpvar_40[1].w = 0.0;
  tmpvar_40[2].x = (tmpvar_35 * tmpvar_38);
  tmpvar_40[2].y = (tmpvar_35 * tmpvar_39);
  tmpvar_40[2].z = (localScale_5 * (1.0 - tmpvar_31));
  tmpvar_40[2].w = 0.0;
  tmpvar_40[3].x = trans_28.x;
  tmpvar_40[3].y = trans_28.y;
  tmpvar_40[3].z = trans_28.z;
  tmpvar_40[3].w = 1.0;
  mat4 tmpvar_41;
  tmpvar_41 = (((unity_MatrixV * _Object2World) * tmpvar_40));
  vec4 v_42;
  v_42.x = tmpvar_41[0].z;
  v_42.y = tmpvar_41[1].z;
  v_42.z = tmpvar_41[2].z;
  v_42.w = tmpvar_41[3].z;
  vec3 tmpvar_43;
  tmpvar_43 = normalize(v_42.xyz);
  vec4 tmpvar_44;
  tmpvar_44 = (gl_ModelViewMatrix * localOrigin_6);
  vec4 tmpvar_45;
  tmpvar_45.xyz = (gl_Vertex.xyz * localScale_5);
  tmpvar_45.w = gl_Vertex.w;
  vec4 tmpvar_46;
  tmpvar_46 = (gl_ProjectionMatrix * (tmpvar_44 + tmpvar_45));
  vec2 tmpvar_47;
  tmpvar_47 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_48;
  tmpvar_48.z = 0.0;
  tmpvar_48.x = tmpvar_47.x;
  tmpvar_48.y = tmpvar_47.y;
  tmpvar_48.w = gl_Vertex.w;
  ZYv_3.xyw = tmpvar_48.zyw;
  XZv_2.yzw = tmpvar_48.zyw;
  XYv_1.yzw = tmpvar_48.yzw;
  ZYv_3.z = (tmpvar_47.x * sign(-(tmpvar_43.x)));
  XZv_2.x = (tmpvar_47.x * sign(-(tmpvar_43.y)));
  XYv_1.x = (tmpvar_47.x * sign(tmpvar_43.z));
  ZYv_3.x = ((sign(-(tmpvar_43.x)) * sign(ZYv_3.z)) * tmpvar_43.z);
  XZv_2.y = ((sign(-(tmpvar_43.y)) * sign(XZv_2.x)) * tmpvar_43.x);
  XYv_1.z = ((sign(-(tmpvar_43.z)) * sign(XYv_1.x)) * tmpvar_43.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_43.x)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_43.y)) * sign(tmpvar_47.y)) * tmpvar_43.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_43.z)) * sign(tmpvar_47.y)) * tmpvar_43.y));
  vec4 tmpvar_49;
  tmpvar_49.w = 0.0;
  tmpvar_49.xyz = gl_Normal;
  vec3 tmpvar_50;
  tmpvar_50 = normalize((_Object2World * tmpvar_49).xyz);
  vec4 c_51;
  float tmpvar_52;
  tmpvar_52 = dot (normalize(tmpvar_50), normalize(_WorldSpaceLightPos0.xyz));
  c_51.xyz = (((tmpvar_22.xyz * _LightColor0.xyz) * tmpvar_52) * 4.0);
  c_51.w = (tmpvar_52 * 4.0);
  float tmpvar_53;
  tmpvar_53 = dot (tmpvar_50, normalize(_WorldSpaceLightPos0).xyz);
  tmpvar_7.xyz = (c_51 * mix (1.0, clamp (floor((1.01 + tmpvar_53)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_53)), 0.0, 1.0))).xyz;
  vec4 o_54;
  vec4 tmpvar_55;
  tmpvar_55 = (tmpvar_46 * 0.5);
  vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_55.x;
  tmpvar_56.y = (tmpvar_55.y * _ProjectionParams.x);
  o_54.xy = (tmpvar_56 + tmpvar_55.w);
  o_54.zw = tmpvar_46.zw;
  tmpvar_8.xyw = o_54.xyw;
  tmpvar_8.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_46;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_43);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * ZYv_3).xy - tmpvar_44.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XZv_2).xy - tmpvar_44.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_41 * XYv_1).xy - tmpvar_44.xy)));
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD4;
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
  color_1.xyz = tmpvar_2.xyz;
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Vector 27 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [unity_MatrixV]
Vector 28 [_LightColor0]
Matrix 16 [_MainRotation]
Matrix 20 [_DetailRotation]
Float 29 [_DetailScale]
Float 30 [_DistFade]
Float 31 [_DistFadeVert]
Float 32 [_Rotation]
Float 33 [_MaxScale]
Vector 34 [_MaxTrans]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"vs_3_0
; 358 ALU, 4 TEX
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c35, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c36, 123.54530334, 2.00000000, -1.00000000, 1.00000000
def c37, 0.00000000, -0.01872930, 0.07426100, -0.21211439
def c38, 1.57072902, 3.14159298, 0.31830987, -0.12123910
def c39, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c40, 0.99999559, 1.57079601, 0.15915494, 0.50000000
def c41, 4.00000000, 10.00000000, 1.00976563, 6.28318548
def c42, 0.00000000, 1.00000000, 0.60000002, 0.50000000
dcl_2d s0
dcl_2d s1
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mad r9.xy, v2, c36.y, c36.z
mov r1.w, c11
mov r1.z, c10.w
mov r1.x, c8.w
mov r1.y, c9.w
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
frc r1.xyz, -r0
add r0.xyz, -r0, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r0.x, r1, c35, c35.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c35.x, c35.y
frc r0.y, r0.z
mad r0.x, r1.y, c35, c35.y
mad r0.y, r0, c35.z, c35.w
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c35.z, c35.w
sincos r0.xy, r1.x
mov r0.z, r1.y
mul r0.xyz, r0, c36.x
frc r0.xyz, r0
abs r4.xyz, r0
mad r0.xyz, r4, c36.y, c36.z
mul r0.xyz, r0, c34
mov r0.w, c36
dp4 r2.w, r0, c11
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp4 r1.z, r2, c18
dp4 r1.x, r2, c16
dp4 r1.y, r2, c17
dp4 r1.w, r2, c19
add r2.xyz, -r2, c24
dp4 r3.z, -r1, c22
dp4 r3.x, -r1, c20
dp4 r3.y, -r1, c21
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
abs r3.xyz, r3
sge r1.w, r3.z, r3.x
add r5.xyz, r3.zxyw, -r3
mad r5.xyz, r1.w, r5, r3
sge r2.w, r5.x, r3.y
add r5.xyz, r5, -r3.yxzw
mad r3.xyz, r2.w, r5, r3.yxzw
mul r3.zw, r3.xyzy, c35.y
dp3 r1.w, -r1, -r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, -r1
abs r2.w, r1.z
abs r4.w, r1.x
slt r1.z, r1, c37.x
max r1.w, r2, r4
abs r3.y, r3.x
rcp r3.x, r1.w
min r1.w, r2, r4
mul r1.w, r1, r3.x
slt r2.w, r2, r4
rcp r3.x, r3.y
mul r3.xy, r3.zwzw, r3.x
mul r5.x, r1.w, r1.w
mad r3.z, r5.x, c39.x, c39.y
mad r5.y, r3.z, r5.x, c38.w
mad r5.y, r5, r5.x, c39.z
mad r4.w, r5.y, r5.x, c39
mad r4.w, r4, r5.x, c40.x
mul r1.w, r4, r1
max r2.w, -r2, r2
slt r2.w, c37.x, r2
add r5.x, -r2.w, c36.w
add r4.w, -r1, c40.y
mul r1.w, r1, r5.x
mad r4.w, r2, r4, r1
max r1.z, -r1, r1
slt r2.w, c37.x, r1.z
abs r1.z, r1.y
mad r1.w, r1.z, c37.y, c37.z
mad r1.w, r1, r1.z, c37
mad r1.w, r1, r1.z, c38.x
add r5.x, -r4.w, c38.y
add r5.y, -r2.w, c36.w
mul r4.w, r4, r5.y
mad r4.w, r2, r5.x, r4
slt r2.w, r1.x, c37.x
add r1.z, -r1, c36.w
rsq r1.x, r1.z
max r1.z, -r2.w, r2.w
slt r2.w, c37.x, r1.z
rcp r1.x, r1.x
mul r1.z, r1.w, r1.x
slt r1.x, r1.y, c37
mul r1.y, r1.x, r1.z
mad r1.y, -r1, c36, r1.z
add r1.w, -r2, c36
mul r1.w, r4, r1
mad r1.y, r1.x, c38, r1
mad r1.z, r2.w, -r4.w, r1.w
mad r1.x, r1.z, c40.z, c40.w
mul r3.xy, r3, c29.x
mov r3.z, c37.x
texldl r3, r3.xyzz, s1
mul r1.y, r1, c38.z
mov r1.z, c37.x
texldl r1, r1.xyzz, s0
mul r1, r1, r3
mov r3.xyz, v1
mov r3.w, c37.x
dp4 r5.z, r3, c10
dp4 r5.x, r3, c8
dp4 r5.y, r3, c9
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
dp3 r3.w, c27, c27
rsq r3.w, r3.w
mul r6.xyz, r2.w, r5
mul r7.xyz, r3.w, c27
dp3 r2.w, r6, r7
mul r1.xyz, r1, c28
mul r1.xyz, r1, r2.w
mul r1.xyz, r1, c41.x
mov r3.yz, c37.x
frc r3.x, c32
add r3.xyz, r4, r3
mul r3.y, r3, c41.w
mad r2.w, r3.y, c35.x, c35.y
frc r3.y, r2.w
mul r2.w, r3.z, c36.y
mad r3.y, r3, c35.z, c35.w
sincos r6.xy, r3.y
rsq r3.z, r2.w
rcp r3.y, r3.z
mul r3.z, r3.x, c41.w
mad r3.w, r3.z, c35.x, c35.y
mul r4.w, r6.y, r3.y
mul r5.w, r6.x, r3.y
dp4 r3.y, c27, c27
rsq r3.x, r3.y
mul r3.xyz, r3.x, c27
dp3 r4.y, r5, r3
frc r3.w, r3
mad r5.x, r3.w, c35.z, c35.w
sincos r3.xy, r5.x
add r4.z, r4.y, c41
frc r3.z, r4
add_sat r3.z, r4, -r3
add r3.w, r3.z, c36.z
mul_sat r3.z, -r4.y, c41.y
mul r4.z, r5.w, r3.x
mad r3.z, r3, r3.w, c36.w
mul o1.xyz, r1, r3.z
mad r4.y, r4.w, r3, r4.z
add r1.z, -r2.w, c36.y
rsq r1.z, r1.z
rcp r3.w, r1.z
mov r1.y, c33.x
add r1.y, c36.z, r1
mad r7.w, r4.x, r1.y, c36
mad r3.z, r5.w, r4.y, -r3.x
mul r1.y, r7.w, r3.z
mul r3.z, r5.w, r3.y
mad r3.z, r4.w, r3.x, -r3
mad r1.x, r4.w, r4.y, -r3.y
mul r1.z, r3.w, r4.y
mov r4.x, c14.y
mad r3.x, r4.w, r3.z, -r3
mov r5.x, c14
mul r4.xyz, c9, r4.x
mad r4.xyz, c8, r5.x, r4
mov r5.x, c14.z
mad r4.xyz, c10, r5.x, r4
mov r5.x, c14.w
mad r4.xyz, c11, r5.x, r4
mul r5.xyz, r4.y, r1
dp3 r4.y, r2, r2
mad r2.y, r5.w, r3.z, r3
mul r2.z, r3.w, r3
mul r2.x, r7.w, r3
mad r3.xyz, r4.x, r2, r5
mul r5.y, r3.w, r5.w
add r2.w, -r2, c36
mul r5.x, r4.w, r3.w
mul r5.z, r7.w, r2.w
rsq r4.x, r4.y
rcp r2.w, r4.x
mul r3.w, -r2, c31.x
mad r3.xyz, r4.z, r5, r3
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r7.xyz, r4.x, r3
add_sat r3.w, r3, c36
mul_sat r2.w, r2, c30.x
mul r2.w, r2, r3
mul o1.w, r1, r2
slt r2.w, -r7.x, r7.x
slt r1.w, r7.x, -r7.x
sub r1.w, r1, r2
slt r3.x, r9.y, -r9.y
slt r2.w, -r9.y, r9.y
sub r9.z, r2.w, r3.x
mul r2.w, r9.x, r1
mul r3.z, r1.w, r9
slt r3.y, r2.w, -r2.w
slt r3.x, -r2.w, r2.w
sub r3.x, r3, r3.y
mov r8.z, r2.w
mov r2.w, r0.x
mul r1.w, r3.x, r1
mul r3.y, r7, r3.z
mad r8.x, r7.z, r1.w, r3.y
mov r1.w, c12.y
mul r3, c9, r1.w
mov r1.w, c12.x
mad r3, c8, r1.w, r3
mov r1.w, c12.z
mad r3, c10, r1.w, r3
mov r1.w, c12
mad r6, c11, r1.w, r3
mov r1.w, r0.y
mul r4, r1, r6.y
mov r3.x, c13.y
mov r5.w, c13.x
mul r3, c9, r3.x
mad r3, c8, r5.w, r3
mov r5.w, c13.z
mad r3, c10, r5.w, r3
mov r5.w, c13
mad r3, c11, r5.w, r3
mul r1, r3.y, r1
mov r5.w, r0.z
mad r1, r3.x, r2, r1
mad r1, r3.z, r5, r1
mad r1, r3.w, c42.xxxy, r1
mad r4, r2, r6.x, r4
mad r4, r5, r6.z, r4
mad r2, r6.w, c42.xxxy, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
mov r4.w, v0
mov r4.y, r9
mov r8.yw, r4
dp4 r3.y, r1, r8
dp4 r3.x, r8, r2
slt r3.w, -r7.y, r7.y
slt r3.z, r7.y, -r7.y
sub r4.x, r3.z, r3.w
add r3.zw, -r5.xyxy, r3.xyxy
mul r3.x, r9, r4
mad o3.xy, r3.zwzw, c42.z, c42.w
slt r3.z, r3.x, -r3.x
slt r3.y, -r3.x, r3.x
sub r3.y, r3, r3.z
mul r3.z, r9, r4.x
mul r3.y, r3, r4.x
mul r4.x, r7.z, r3.z
mad r3.y, r7.x, r3, r4.x
mov r3.zw, r4.xyyw
dp4 r5.w, r1, r3
dp4 r5.z, r2, r3
add r3.xy, -r5, r5.zwzw
slt r3.w, -r7.z, r7.z
slt r3.z, r7, -r7
sub r4.x, r3.w, r3.z
sub r3.z, r3, r3.w
mul r4.x, r9, r4
mul r5.z, r9, r3
dp4 r5.w, r0, c3
slt r4.z, r4.x, -r4.x
slt r3.w, -r4.x, r4.x
sub r3.w, r3, r4.z
mul r4.z, r7.y, r5
dp4 r5.z, r0, c2
mul r3.z, r3, r3.w
mad r4.z, r7.x, r3, r4
dp4 r1.y, r1, r4
dp4 r1.x, r2, r4
mad o4.xy, r3, c42.z, c42.w
add r3.xy, -r5, r1
mov r0.w, v0
mul r0.xyz, v0, r7.w
add r0, r5, r0
dp4 r2.w, r0, c7
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r1.w, r2
dp4 r1.z, r0, c6
mul r2.xyz, r1.xyww, c35.y
mul r2.y, r2, c25.x
dp4 r0.x, v0, c2
mad o5.xy, r3, c42.z, c42.w
mad o6.xy, r2.z, c26.zwzw, r2
abs o2.xyz, r7
mov o0, r1
mov o6.w, r2
mov o6.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 320 // 316 used size, 16 vars
Vector 80 [_LightColor0] 4
Matrix 112 [_MainRotation] 4
Matrix 176 [_DetailRotation] 4
Float 240 [_DetailScale]
Float 272 [_DistFade]
Float 276 [_DistFadeVert]
Float 292 [_Rotation]
Float 296 [_MaxScale]
Vector 304 [_MaxTrans] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 144 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Matrix 80 [unity_MatrixV] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 247 instructions, 11 temp regs, 0 temp arrays:
// ALU 211 float, 8 int, 6 uint
// TEX 0 (2 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedinmljikmaidcgbficcikcnpmcnobkmleabaaaaaajaccaaaaadaaaaaa
cmaaaaaanmaaaaaalaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnicaaaaaeaaaabaadgaiaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacalaaaaaadiaaaaajhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaafgifcaaaadaaaaaaapaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaaagiacaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaakgikcaaaadaaaaaaapaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
pgipcaaaadaaaaaaapaaaaaaegacbaaaaaaaaaaaebaaaaaghcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaenaaaaaghcaabaaa
aaaaaaaaaanaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadcbhphecdcbhphecdcbhphecaaaaaaaabkaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaa
bcaaaaaaabeaaaaaaaaaialpdcaaaaajicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaadkbabaaaaaaaaaaa
dcaaaaaphcaabaaaacaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaadaaaaaafgafbaaaacaaaaaaegiocaaaadaaaaaaafaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
adaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaaadaaaaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaadaaaaaaahaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaabaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
aeaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaabaaaaaaegaobaaaaeaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaadaaaaaa
apaaaaaadiaaaaaipcaabaaaafaaaaaafgafbaaaaeaaaaaaegiocaaaaaaaaaaa
aiaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaaahaaaaaaagaabaaa
aeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaaegiocaaaaaaaaaaa
ajaaaaaakgakbaaaaeaaaaaaegaobaaaafaaaaaadcaaaaakpcaabaaaafaaaaaa
egiocaaaaaaaaaaaakaaaaaapgapbaaaaeaaaaaaegaobaaaafaaaaaaaaaaaaaj
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaajhcaabaaaaeaaaaaafgafbaia
ebaaaaaaafaaaaaabgigcaaaaaaaaaaaamaaaaaadcaaaaalhcaabaaaaeaaaaaa
bgigcaaaaaaaaaaaalaaaaaaagaabaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaaanaaaaaakgakbaiaebaaaaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaabgigcaaaaaaaaaaa
aoaaaaaapgapbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaabnaaaaajicaabaaaacaaaaaackaabaiaibaaaaaaaeaaaaaabkaabaia
ibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaajpcaabaaaagaaaaaafgaibaiambaaaaaaaeaaaaaakgabbaia
ibaaaaaaaeaaaaaadiaaaaahecaabaaaahaaaaaadkaabaaaacaaaaaadkaabaaa
agaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
fgaebaiaibaaaaaaaeaaaaaadgaaaaagdcaabaaaahaaaaaaegaabaiambaaaaaa
aeaaaaaadgaaaaaficaabaaaagaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
agaaaaaafgaobaaaagaaaaaaagajbaaaahaaaaaabnaaaaaiicaabaaaacaaaaaa
akaabaaaagaaaaaaakaabaiaibaaaaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaa
acaaaaaajgahbaaaagaaaaaaegacbaiaibaaaaaaaeaaaaaadiaaaaakmcaabaaa
adaaaaaakgagbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
aoaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaabaaaaeaaaaaadiaaaaai
mcaabaaaadaaaaaakgaobaaaadaaaaaaagiacaaaaaaaaaaaapaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaabaaaaaajicaabaaaacaaaaaaegacbaiaebaaaaaaafaaaaaa
egacbaiaebaaaaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaaihcaabaaaafaaaaaapgapbaaaacaaaaaaigabbaiaebaaaaaaafaaaaaa
deaaaaajicaabaaaacaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaa
afaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaacaaaaaaddaaaaajecaabaaaadaaaaaabkaabaiaibaaaaaa
afaaaaaaakaabaiaibaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
afaaaaaabkaabaiaibaaaaaaafaaaaaaakaabaiaibaaaaaaafaaaaaaabaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaadbaaaaai
mcaabaaaadaaaaaafgajbaaaafaaaaaafgajbaiaebaaaaaaafaaaaaaabaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahecaabaaaadaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaadbaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaaafaaaaaabkaabaaa
afaaaaaaakaabaaaafaaaaaabnaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaa
akaabaiaebaaaaaaafaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaafaaaaaadhaaaaakicaabaaaacaaaaaackaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaa
acaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaacaaaaaa
ckaabaiaibaaaaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaaafaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaackaabaiaibaaaaaa
afaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaadaaaaaackaabaiambaaaaaa
afaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaaj
icaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaaidpjkcdoeiaaaaal
pcaabaaaafaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaadiaaaaaiicaabaaaacaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaa
bbaaaaaadccaaaalecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabbaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdgcaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahiccabaaaabaaaaaackaabaaaabaaaaaadkaabaaaaeaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaafaaaaaabaaaaaaj
ecaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaa
kgakbaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaagaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaagaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaagaaaaaadcaaaaak
hcaabaaaagaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
agaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
kgakbaaaabaaaaaaegacbaaaagaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaabbaaaaajecaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaaabaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaaaaaaaaahicaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaakoehibdp
dicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaacambebcaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaialpdcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaabaaaaaakgakbaaa
abaaaaaaegacbaaaaeaaaaaabkaaaaagbcaabaaaaeaaaaaabkiacaaaaaaaaaaa
bcaaaaaadgaaaaaigcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaanlapmjeanlapmjeaaaaaaaaaaaaaaaaadcaaaabamcaabaaa
adaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaiadpenaaaaahbcaabaaa
aeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaagaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaeaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaajhcaabaaaaeaaaaaafgifcaaaadaaaaaa
anaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaa
aeaaaaaaafaaaaaaagiacaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadcaaaaal
hcaabaaaaeaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaanaaaaaa
egacbaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaaegiccaaaaeaaaaaaaiaaaaaa
pgipcaaaadaaaaaaanaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaacaaaaaackaabaaaaaaaaaaa
akaabaaaagaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajicaabaaaaeaaaaaa
bkaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaa
agaaaaaafgifcaaaadaaaaaaamaaaaaaagijcaaaaeaaaaaaagaaaaaadcaaaaal
ocaabaaaagaaaaaaagijcaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaamaaaaaa
fgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaaagijcaaaaeaaaaaaahaaaaaa
kgikcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaadcaaaaalocaabaaaagaaaaaa
agijcaaaaeaaaaaaaiaaaaaapgipcaaaadaaaaaaamaaaaaafgaobaaaagaaaaaa
dcaaaaajhcaabaaaafaaaaaajgahbaaaagaaaaaapgapbaaaaeaaaaaaegacbaaa
afaaaaaaelaaaaafecaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaajhcaabaaaahaaaaaafgifcaaa
adaaaaaaaoaaaaaaegiccaaaaeaaaaaaagaaaaaadcaaaaalhcaabaaaahaaaaaa
egiccaaaaeaaaaaaafaaaaaaagiacaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaa
dcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaa
aoaaaaaaegacbaaaahaaaaaadcaaaaalhcaabaaaahaaaaaaegiccaaaaeaaaaaa
aiaaaaaapgipcaaaadaaaaaaaoaaaaaaegacbaaaahaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaafaaaaaadgaaaaaf
ccaabaaaaiaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaaagaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahhcaabaaaajaaaaaa
kgakbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaajaaaaaajgahbaaa
agaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaajaaaaaa
egacbaaaahaaaaaapgapbaaaadaaaaaaegacbaaaajaaaaaadiaaaaahhcaabaaa
akaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahkcaabaaaacaaaaaa
fgafbaaaacaaaaaaagaebaaaaeaaaaaadcaaaaajdcaabaaaacaaaaaajgafbaaa
agaaaaaaagaabaaaacaaaaaangafbaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaahaaaaaakgakbaaaacaaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajlcaabaaaaaaaaaaa
jganbaaaagaaaaaaagaabaaaaaaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaahaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaf
bcaabaaaaiaaaaaackaabaaaaaaaaaaadgaaaaafecaabaaaaiaaaaaackaabaaa
ajaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaaiaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaeaaaaaadiaaaaajmcaabaaaaaaaaaaafgifcaaaadaaaaaaapaaaaaa
agiecaaaaeaaaaaaagaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaa
afaaaaaaagiacaaaadaaaaaaapaaaaaakgaobaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiecaaaaeaaaaaaahaaaaaakgikcaaaadaaaaaaapaaaaaakgaobaaa
aaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiecaaaaeaaaaaaaiaaaaaapgipcaaa
adaaaaaaapaaaaaakgaobaaaaaaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaacaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaadbaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
agaaaaaadcaaaaapmcaabaaaadaaaaaaagbebaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaadaaaaaadbaaaaah
icaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaaiaanaaaaa
hcaabaaaagaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaagaaaaaajgafbaaaaeaaaaaa
egacbaaaagaaaaaaclaaaaafkcaabaaaaeaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaaeaaaaaakgakbaaaadaaaaaafganbaaaaeaaaaaadbaaaaakmcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaeaaaaaa
dbaaaaakdcaabaaaahaaaaaangafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaakgaobaiaebaaaaaaafaaaaaa
agaebaaaahaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaafaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaaeaaaaaaegaabaaaagaaaaaa
diaaaaahkcaabaaaacaaaaaafgafbaaaacaaaaaaagaebaaaafaaaaaadiaaaaah
dcaabaaaafaaaaaapgapbaaaadaaaaaaegaabaaaafaaaaaadcaaaaajmcaabaaa
afaaaaaaagaebaaaaaaaaaaaagaabaaaacaaaaaaagaebaaaafaaaaaadcaaaaaj
mcaabaaaafaaaaaaagaebaaaajaaaaaafgafbaaaaeaaaaaakgaobaaaafaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaaaaaaaaapgapbaaaaeaaaaaangafbaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaajaaaaaapgapbaaaadaaaaaa
egaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapmccabaaaadaaaaaaagaebaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdcaaaaajdcaabaaaacaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaogakbaaaafaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aeaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
claaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadbaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaacaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
abaaaaaaegaabaaaafaaaaaaboaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaacgaaaaaiaanaaaaaecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaaclaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaa
agaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaajaaaaaakgakbaaaabaaaaaa
egaabaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaogakbaaaaaaaaaaapgbpbaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaadgaaaaaficcabaaaafaaaaaadkaabaaaabaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _MaxTrans;
uniform highp float _MaxScale;
uniform highp float _Rotation;
uniform highp float _DistFadeVert;
uniform highp float _DistFade;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform lowp vec4 _LightColor0;
uniform highp mat4 unity_MatrixV;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 XYv_2;
  highp vec4 XZv_3;
  highp vec4 ZYv_4;
  highp vec3 detail_pos_5;
  highp float localScale_6;
  highp vec4 localOrigin_7;
  lowp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = abs(fract((sin(normalize(floor(-((_MainRotation * (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)))).xyz))) * 123.545)));
  localOrigin_7.xyz = (((2.0 * tmpvar_10) - 1.0) * _MaxTrans);
  localOrigin_7.w = 1.0;
  localScale_6 = ((tmpvar_10.x * (_MaxScale - 1.0)) + 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * localOrigin_7);
  highp vec4 tmpvar_12;
  tmpvar_12 = -((_MainRotation * tmpvar_11));
  detail_pos_5 = (_DetailRotation * tmpvar_12).xyz;
  mediump vec4 tex_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12.xyz);
  highp vec2 uv_15;
  highp float r_16;
  if ((abs(tmpvar_14.z) > (1e-08 * abs(tmpvar_14.x)))) {
    highp float y_over_x_17;
    y_over_x_17 = (tmpvar_14.x / tmpvar_14.z);
    highp float s_18;
    highp float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((tmpvar_14.z < 0.0)) {
      if ((tmpvar_14.x >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(tmpvar_14.x) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_16));
  uv_15.y = (0.31831 * (1.5708 - (sign(tmpvar_14.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_14.y))) * (1.5708 + (abs(tmpvar_14.y) * (-0.214602 + (abs(tmpvar_14.y) * (0.0865667 + (abs(tmpvar_14.y) * -0.0310296)))))))))));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DLod (_MainTex, uv_15, 0.0);
  tex_13 = tmpvar_20;
  tmpvar_8 = tex_13;
  mediump vec4 tmpvar_21;
  highp vec4 uv_22;
  mediump vec3 detailCoords_23;
  mediump float nylerp_24;
  mediump float zxlerp_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(normalize(detail_pos_5));
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_25 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_25) >= tmpvar_26.y));
  nylerp_24 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_25));
  detailCoords_23 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_23, vec3(nylerp_24));
  detailCoords_23 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_23.x);
  uv_22.xy = (((0.5 * detailCoords_23.zy) / tmpvar_31) * _DetailScale);
  uv_22.zw = vec2(0.0, 0.0);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_DetailTex, uv_22.xy, 0.0);
  tmpvar_21 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_8 * tmpvar_21);
  tmpvar_8 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_35;
  highp vec4 p_36;
  p_36 = (tmpvar_11 - tmpvar_34);
  tmpvar_35 = sqrt(dot (p_36, p_36));
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_8.w * (clamp ((_DistFade * tmpvar_35), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * tmpvar_35)), 0.0, 1.0)));
  tmpvar_8.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38.yz = vec2(0.0, 0.0);
  tmpvar_38.x = fract(_Rotation);
  highp vec3 x_39;
  x_39 = (tmpvar_38 + tmpvar_10);
  highp vec3 trans_40;
  trans_40 = localOrigin_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (x_39.x * 6.28319);
  highp float tmpvar_42;
  tmpvar_42 = (x_39.y * 6.28319);
  highp float tmpvar_43;
  tmpvar_43 = (x_39.z * 2.0);
  highp float tmpvar_44;
  tmpvar_44 = sqrt(tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (sin(tmpvar_42) * tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (cos(tmpvar_42) * tmpvar_44);
  highp float tmpvar_47;
  tmpvar_47 = sqrt((2.0 - tmpvar_43));
  highp float tmpvar_48;
  tmpvar_48 = sin(tmpvar_41);
  highp float tmpvar_49;
  tmpvar_49 = cos(tmpvar_41);
  highp float tmpvar_50;
  tmpvar_50 = ((tmpvar_45 * tmpvar_49) - (tmpvar_46 * tmpvar_48));
  highp float tmpvar_51;
  tmpvar_51 = ((tmpvar_45 * tmpvar_48) + (tmpvar_46 * tmpvar_49));
  highp mat4 tmpvar_52;
  tmpvar_52[0].x = (localScale_6 * ((tmpvar_45 * tmpvar_50) - tmpvar_49));
  tmpvar_52[0].y = ((tmpvar_45 * tmpvar_51) - tmpvar_48);
  tmpvar_52[0].z = (tmpvar_45 * tmpvar_47);
  tmpvar_52[0].w = 0.0;
  tmpvar_52[1].x = ((tmpvar_46 * tmpvar_50) + tmpvar_48);
  tmpvar_52[1].y = (localScale_6 * ((tmpvar_46 * tmpvar_51) - tmpvar_49));
  tmpvar_52[1].z = (tmpvar_46 * tmpvar_47);
  tmpvar_52[1].w = 0.0;
  tmpvar_52[2].x = (tmpvar_47 * tmpvar_50);
  tmpvar_52[2].y = (tmpvar_47 * tmpvar_51);
  tmpvar_52[2].z = (localScale_6 * (1.0 - tmpvar_43));
  tmpvar_52[2].w = 0.0;
  tmpvar_52[3].x = trans_40.x;
  tmpvar_52[3].y = trans_40.y;
  tmpvar_52[3].z = trans_40.z;
  tmpvar_52[3].w = 1.0;
  highp mat4 tmpvar_53;
  tmpvar_53 = (((unity_MatrixV * _Object2World) * tmpvar_52));
  vec4 v_54;
  v_54.x = tmpvar_53[0].z;
  v_54.y = tmpvar_53[1].z;
  v_54.z = tmpvar_53[2].z;
  v_54.w = tmpvar_53[3].z;
  vec3 tmpvar_55;
  tmpvar_55 = normalize(v_54.xyz);
  highp vec4 tmpvar_56;
  tmpvar_56 = (glstate_matrix_modelview0 * localOrigin_7);
  highp vec4 tmpvar_57;
  tmpvar_57.xyz = (_glesVertex.xyz * localScale_6);
  tmpvar_57.w = _glesVertex.w;
  highp vec4 tmpvar_58;
  tmpvar_58 = (glstate_matrix_projection * (tmpvar_56 + tmpvar_57));
  highp vec2 tmpvar_59;
  tmpvar_59 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_60;
  tmpvar_60.z = 0.0;
  tmpvar_60.x = tmpvar_59.x;
  tmpvar_60.y = tmpvar_59.y;
  tmpvar_60.w = _glesVertex.w;
  ZYv_4.xyw = tmpvar_60.zyw;
  XZv_3.yzw = tmpvar_60.zyw;
  XYv_2.yzw = tmpvar_60.yzw;
  ZYv_4.z = (tmpvar_59.x * sign(-(tmpvar_55.x)));
  XZv_3.x = (tmpvar_59.x * sign(-(tmpvar_55.y)));
  XYv_2.x = (tmpvar_59.x * sign(tmpvar_55.z));
  ZYv_4.x = ((sign(-(tmpvar_55.x)) * sign(ZYv_4.z)) * tmpvar_55.z);
  XZv_3.y = ((sign(-(tmpvar_55.y)) * sign(XZv_3.x)) * tmpvar_55.x);
  XYv_2.z = ((sign(-(tmpvar_55.z)) * sign(XYv_2.x)) * tmpvar_55.x);
  ZYv_4.x = (ZYv_4.x + ((sign(-(tmpvar_55.x)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  XZv_3.y = (XZv_3.y + ((sign(-(tmpvar_55.y)) * sign(tmpvar_59.y)) * tmpvar_55.z));
  XYv_2.z = (XYv_2.z + ((sign(-(tmpvar_55.z)) * sign(tmpvar_59.y)) * tmpvar_55.y));
  highp vec4 tmpvar_61;
  tmpvar_61.w = 0.0;
  tmpvar_61.xyz = tmpvar_1;
  highp vec3 tmpvar_62;
  tmpvar_62 = normalize((_Object2World * tmpvar_61).xyz);
  highp vec3 tmpvar_63;
  tmpvar_63 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
  lowp vec3 tmpvar_64;
  tmpvar_64 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_65;
  lightDir_65 = tmpvar_64;
  mediump vec3 viewDir_66;
  viewDir_66 = tmpvar_63;
  mediump vec3 normal_67;
  normal_67 = tmpvar_62;
  mediump vec4 color_68;
  color_68 = tmpvar_8;
  mediump vec4 c_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = normalize(lightDir_65);
  lightDir_65 = tmpvar_70;
  viewDir_66 = normalize(viewDir_66);
  mediump vec3 tmpvar_71;
  tmpvar_71 = normalize(normal_67);
  normal_67 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (tmpvar_71, tmpvar_70);
  highp vec3 tmpvar_73;
  tmpvar_73 = (((color_68.xyz * _LightColor0.xyz) * tmpvar_72) * 4.0);
  c_69.xyz = tmpvar_73;
  c_69.w = (tmpvar_72 * 4.0);
  lowp vec3 tmpvar_74;
  tmpvar_74 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_75;
  lightDir_75 = tmpvar_74;
  mediump vec3 normal_76;
  normal_76 = tmpvar_62;
  mediump float tmpvar_77;
  tmpvar_77 = dot (normal_76, lightDir_75);
  mediump vec3 tmpvar_78;
  tmpvar_78 = (c_69 * mix (1.0, clamp (floor((1.01 + tmpvar_77)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_77)), 0.0, 1.0))).xyz;
  tmpvar_8.xyz = tmpvar_78;
  highp vec4 o_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = (tmpvar_58 * 0.5);
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_80.x;
  tmpvar_81.y = (tmpvar_80.y * _ProjectionParams.x);
  o_79.xy = (tmpvar_81 + tmpvar_80.w);
  o_79.zw = tmpvar_58.zw;
  tmpvar_9.xyw = o_79.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_58;
  xlv_COLOR = tmpvar_8;
  xlv_TEXCOORD0 = abs(tmpvar_55);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * ZYv_4).xy - tmpvar_56.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XZv_3).xy - tmpvar_56.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((tmpvar_53 * XYv_2).xy - tmpvar_56.xy)));
  xlv_TEXCOORD4 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
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
  color_3.xyz = tmpvar_14.xyz;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD4.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 464
highp float GetDistanceFade( in highp float dist, in highp float fade, in highp float fadeVert ) {
    highp float fadeDist = (fade * dist);
    highp float distVert = (1.0 - (fadeVert * dist));
    #line 468
    return (xll_saturate_f(fadeDist) * xll_saturate_f(distVert));
}
#line 439
mediump vec4 GetShereDetailMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    highp vec3 sphereVectNorm = normalize(sphereVect);
    sphereVectNorm = abs(sphereVectNorm);
    #line 443
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 447
    highp vec4 uv;
    uv.xy = (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale);
    uv.zw = vec2( 0.0, 0.0);
    return xll_tex2Dlod( texSampler, uv);
}
#line 414
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    #line 418
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    return uv;
}
#line 422
mediump vec4 GetSphereMapNoLOD( in sampler2D texSampler, in highp vec3 sphereVect ) {
    highp vec4 uv;
    highp vec3 sphereVectNorm = normalize(sphereVect);
    #line 426
    uv.xy = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    uv.zw = vec2( 0.0, 0.0);
    mediump vec4 tex = xll_tex2Dlod( texSampler, uv);
    return tex;
}
#line 480
mediump vec4 SpecularColorLight( in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump vec3 normal, in mediump vec4 color, in mediump vec4 specColor, in highp float specK, in mediump float atten ) {
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    #line 484
    normal = normalize(normal);
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diffuse = dot( normal, lightDir);
    highp float nh = xll_saturate_f(dot( h, normal));
    #line 488
    highp float spec = (pow( nh, specK) * specColor.w);
    mediump vec4 c;
    c.xyz = ((((color.xyz * _LightColor0.xyz) * diffuse) + ((_LightColor0.xyz * specColor.xyz) * spec)) * (atten * 4.0));
    c.w = (diffuse * (atten * 4.0));
    #line 492
    return c;
}
#line 494
mediump float Terminator( in mediump vec3 lightDir, in mediump vec3 normal ) {
    #line 496
    mediump float NdotL = dot( normal, lightDir);
    mediump float termlerp = xll_saturate_f((10.0 * (-NdotL)));
    mediump float terminator = mix( 1.0, xll_saturate_f(floor((1.01 + NdotL))), termlerp);
    return terminator;
}
#line 401
highp vec3 hash( in highp vec3 val ) {
    return fract((sin(val) * 123.545));
}
#line 537
highp mat4 rand_rotation( in highp vec3 x, in highp float scale, in highp vec3 trans ) {
    highp float theta = (x.x * 6.28319);
    highp float phi = (x.y * 6.28319);
    #line 541
    highp float z = (x.z * 2.0);
    highp float r = sqrt(z);
    highp float Vx = (sin(phi) * r);
    highp float Vy = (cos(phi) * r);
    #line 545
    highp float Vz = sqrt((2.0 - z));
    highp float st = sin(theta);
    highp float ct = cos(theta);
    highp float Sx = ((Vx * ct) - (Vy * st));
    #line 549
    highp float Sy = ((Vx * st) + (Vy * ct));
    highp mat4 M = mat4( (scale * ((Vx * Sx) - ct)), ((Vx * Sy) - st), (Vx * Vz), 0.0, ((Vy * Sx) + st), (scale * ((Vy * Sy) - ct)), (Vy * Vz), 0.0, (Vz * Sx), (Vz * Sy), (scale * (1.0 - z)), 0.0, trans.x, trans.y, trans.z, 1.0);
    return M;
}
#line 553
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0));
    #line 557
    highp vec4 planet_pos = (-(_MainRotation * origin));
    highp vec3 hashVect = abs(hash( normalize(floor(planet_pos.xyz))));
    highp vec4 localOrigin;
    localOrigin.xyz = (((2.0 * hashVect) - 1.0) * _MaxTrans);
    #line 561
    localOrigin.w = 1.0;
    highp float localScale = ((hashVect.x * (_MaxScale - 1.0)) + 1.0);
    origin = (_Object2World * localOrigin);
    planet_pos = (-(_MainRotation * origin));
    #line 565
    highp vec3 detail_pos = (_DetailRotation * planet_pos).xyz;
    o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz);
    o.color *= GetShereDetailMapNoLOD( _DetailTex, detail_pos, _DetailScale);
    o.color.w *= GetDistanceFade( distance( origin, vec4( _WorldSpaceCameraPos, 0.0)), _DistFade, _DistFadeVert);
    #line 569
    highp mat4 M = rand_rotation( (vec3( fract(_Rotation), 0.0, 0.0) + hashVect), localScale, localOrigin.xyz);
    highp mat4 mvMatrix = ((unity_MatrixV * _Object2World) * M);
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (mvMatrix, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 573
    highp vec4 mvCenter = (glstate_matrix_modelview0 * localOrigin);
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( (v.vertex.xyz * localScale), v.vertex.w)));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    #line 577
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    #line 581
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 585
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 589
    highp vec2 ZY = ((mvMatrix * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((mvMatrix * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((mvMatrix * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    #line 593
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    viewDir = normalize((vec3( origin) - _WorldSpaceCameraPos));
    #line 597
    mediump vec4 color = SpecularColorLight( vec3( _WorldSpaceLightPos0), viewDir, worldNormal, o.color, vec4( 0.0), 0.0, 1.0);
    color *= Terminator( vec3( normalize(_WorldSpaceLightPos0)), worldNormal);
    o.color.xyz = color.xyz;
    o.projPos = ComputeScreenPos( o.pos);
    #line 601
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 526
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 517
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
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 401
#line 405
#line 414
#line 422
#line 431
#line 439
#line 452
#line 464
#line 480
#line 501
uniform sampler2D _TopTex;
uniform sampler2D _LeftTex;
uniform sampler2D _FrontTex;
uniform sampler2D _MainTex;
#line 505
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform highp float _DistFade;
#line 509
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
uniform highp float _MinLight;
uniform highp float _InvFade;
#line 513
uniform highp float _Rotation;
uniform highp float _MaxScale;
uniform highp vec3 _MaxTrans;
uniform sampler2D _CameraDepthTexture;
#line 537
#line 553
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 604
lowp vec4 frag( in v2f IN ) {
    #line 606
    mediump float xval = IN.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, IN.texcoordZY);
    mediump float yval = IN.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, IN.texcoordXZ);
    #line 610
    mediump float zval = IN.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, IN.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * IN.color) * tex);
    #line 614
    mediump vec4 color;
    color.xyz = prev.xyz;
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 618
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 622
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.color = vec4(xlv_COLOR);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_IN.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_IN.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_IN.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   d3d9 - ALU: 13 to 13, TEX: 4 to 4
//   d3d11 - ALU: 13 to 13, TEX: 4 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
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
dcl_texcoord4 v5
texldp r2.x, v5, s3
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
add r2.x, r2, -v5.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mov_pp oC0.xyz, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 256 // 228 used size, 15 vars
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
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpkdbhgligfchjfbhhdiidfhdnclbnekcabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aoaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpnhkdhadpdiaaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
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
dcl_texcoord4 v5
texldp r2.x, v5, s3
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
add r2.x, r2, -v5.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mov_pp oC0.xyz, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 256 // 228 used size, 15 vars
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
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpkdbhgligfchjfbhhdiidfhdnclbnekcabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aoaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpnhkdhadpdiaaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
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
dcl_texcoord4 v5
texldp r2.x, v5, s3
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
add r2.x, r2, -v5.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mov_pp oC0.xyz, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 256 // 228 used size, 15 vars
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
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpkdbhgligfchjfbhhdiidfhdnclbnekcabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aoaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpnhkdhadpdiaaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
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
dcl_texcoord4 v5
texldp r2.x, v5, s3
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
add r2.x, r2, -v5.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mov_pp oC0.xyz, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 320 // 292 used size, 16 vars
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
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkfpcnohfoolbkafdfboofoldeiokbiinabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
bcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpnhkdhadpdiaaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
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
dcl_texcoord4 v5
texldp r2.x, v5, s3
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
add r2.x, r2, -v5.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mov_pp oC0.xyz, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 320 // 292 used size, 16 vars
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
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkfpcnohfoolbkafdfboofoldeiokbiinabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
bcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpnhkdhadpdiaaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
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
dcl_texcoord4 v5
texldp r2.x, v5, s3
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
add r2.x, r2, -v5.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mov_pp oC0.xyz, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 320 // 292 used size, 16 vars
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
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkfpcnohfoolbkafdfboofoldeiokbiinabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaa
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
bcaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpnhkdhadpdiaaaaah
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}

#LINE 259
 
		}
		
	} 
	
}
}