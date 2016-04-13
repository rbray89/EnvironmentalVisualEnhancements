// Compiled shader for all platforms, uncompressed size: 598.9KB

// Skipping shader variants that would not be included into build of current scene.

Shader "EVE/TerrainLight" {
Properties {
 _Color ("Color Tint", Color) = (1,1,1,1)
 _SpecularPower ("Shininess", Float) = 0.078125
 _PlanetOpacity ("PlanetOpacity", Float) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderMode"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 36 avg math (28..40)
 //        d3d9 : 40 avg math (35..44)
 //        gles : 28 avg math (18..41), 2 avg texture (0..6), 0 avg branch (0..4)
 //       metal : 21 avg math (20..24)
 //      opengl : 26 avg math (18..37), 2 avg texture (0..6), 0 avg branch (0..4)
 // Stats for Fragment shader:
 //       d3d11 : 29 avg math (22..39), 2 avg texture (0..6)
 //        d3d9 : 32 avg math (24..44), 2 avg texture (0..6)
 //       metal : 26 avg math (18..37), 2 avg texture (0..6), 0 avg branch (0..4)
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderMode"="Transparent" }
  Lighting On
  ZWrite Off
  Blend SrcColor SrcAlpha, One Zero
  GpuProgramID 55782
Program "vp" {
SubProgram "opengl " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2))).w;
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 39 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
"vs_3_0
def c13, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.xyz
dcl_texcoord5 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c11
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o7.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o4.xyz, r1.w, r1
nrm r1.xyz, c12
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o5.xyz, -r2
add r1.y, r1.x, c13.y
mul_sat r1.x, r1.x, c13.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c13.z
mad o6.x, r1.x, r1.y, c13.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 36 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecedncaejdjkmnpoaliildkofmfpochebapjabaaaaaaoeahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
bcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
iccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaficcabaaa
acaaaaaadkaabaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaafdcaabaaa
abaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaafaaaaaaegacbaiaebaaaaaaabaaaaaaaaaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_9).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  mediump vec3 lightDir_6;
  lightDir_6 = tmpvar_3;
  mediump vec3 normal_7;
  normal_7 = xlv_TEXCOORD4;
  mediump float atten_8;
  atten_8 = tmpvar_5.w;
  mediump vec4 c_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(lightDir_6);
  lightDir_6 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(normal_7);
  normal_7 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, tmpvar_10);
  c_9.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_14;
  lightDir_14 = tmpvar_13;
  mediump vec3 normal_15;
  normal_15 = xlv_TEXCOORD4;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  color_2 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump float t16_2;
mediump float t16_5;
highp float t9;
highp float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t9 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t9);
    t9 = inversesqrt(t9);
    vs_TEXCOORD7.xyz = vec3(t9) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_2 = t0.x + 1.00999999;
    t16_5 = t0.x * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2 = floor(t16_2);
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_2 = t16_2 + -1.0;
    t16_2 = t16_5 * t16_2 + 1.0;
    vs_TEXCOORD6 = t16_2;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].z;
    t16_0.y = _LightMatrix0[1].z;
    t16_0.z = _LightMatrix0[2].z;
    t16_0.w = _LightMatrix0[3].z;
    vs_TEXCOORD2.z = dot(t16_0, t1);
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    vs_TEXCOORD4.xyz = vec3(t10) * t1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp float t10_0;
mediump vec3 t16_1;
mediump vec4 t16_2;
mediump vec3 t16_4;
mediump float t16_7;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t16_1.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t16_4.x = t16_1.x + 1.00999999;
    t16_1.x = t16_1.x * -10.0;
    t16_1.x = clamp(t16_1.x, 0.0, 1.0);
    t16_4.x = floor(t16_4.x);
    t16_4.x = clamp(t16_4.x, 0.0, 1.0);
    t16_4.x = t16_4.x + -1.0;
    t16_1.x = t16_1.x * t16_4.x + 1.0;
    t16_4.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_4.x = inversesqrt(t16_4.x);
    t16_4.xyz = t16_4.xxx * _WorldSpaceLightPos0.xyz;
    t16_2.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_2.x = inversesqrt(t16_2.x);
    t16_2.xyz = t16_2.xxx * vs_TEXCOORD4.xyz;
    t16_4.x = dot(t16_2.xyz, t16_4.xyz);
    t16_2.xyz = _LightColor0.xyz * _Color.xyz;
    t16_2.xyz = t16_4.xxx * t16_2.xyz;
    t0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_0 = texture(_LightTexture0, t0.xx).w;
    t16_7 = t10_0 * 4.0;
    t16_0.xyz = vec3(t16_7) * t16_2.xyz;
    t16_4.x = t16_7 * t16_4.x;
    t16_2.w = t16_1.x * t16_4.x;
    t16_1.xyz = t16_1.xxx * t16_0.xyz;
    t16_2.xyz = t16_2.www * t16_1.xyz;
    SV_Target0 = t16_2;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 21 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 192
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
MatrixHalf 160 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  float3 tmpvar_5;
  float tmpvar_6;
  float4 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _mtl_i._glesNormal;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_5 = -(tmpvar_10.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_11);
  half tmpvar_12;
  tmpvar_12 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_12);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_7)).xyz;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xyz = t0.yyy * _LightMatrix0[1].xyz;
    t1.xyz = _LightMatrix0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = _LightMatrix0[2].xyz * t0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _LightMatrix0[3].xyz * t0.www + t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
lowp vec4 t10_2;
vec3 t3;
float t6;
mediump float t16_6;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_2 = texture(_LightTexture0, vec2(t6));
    t16_6 = t10_2.w * 4.0;
    t1.xyz = vec3(t16_6) * t1.xyz;
    t1.w = t16_6 * t3.x;
    t0 = t0.xxxx * t1;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  vec4 c_2;
  float tmpvar_3;
  tmpvar_3 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_2.xyz = ((_Color.xyz * _LightColor0.xyz) * (tmpvar_3 * 4.0));
  c_2.w = (tmpvar_3 * 4.0);
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_2 * mix (1.0, clamp (
    floor((1.01 + tmpvar_4))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_4))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 35 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 7 [_WorldSpaceCameraPos]
Vector 8 [_WorldSpaceLightPos0]
"vs_3_0
def c9, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord4 o3.xyz
dcl_texcoord5 o4.xyz
dcl_texcoord6 o5.x
dcl_texcoord7 o6.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r0.xyz, r0, -c7
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp o2.w, r0.w
mul o6.xyz, r0.w, r0
dp3 r0.x, c4, v2
dp3 r0.y, c5, v2
dp3 r0.z, c6, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
nrm r0.xyz, c8
mov r1.xy, v3
mov r1.z, v4.x
dp3 r0.x, -r1, r0
mov o4.xyz, -r1
add r0.y, r0.x, c9.y
mul_sat r0.x, r0.x, c9.x
frc r0.z, r0.y
add_sat r0.y, -r0.z, r0.y
add r0.y, r0.y, c9.z
mad o5.x, r0.x, r0.y, c9.w
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 28 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecedcbogfidkgfkiolkedkkdednbmllomegfabaaaaaaiaagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaahaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcleaeaaaaeaaaabaacnabaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaelaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaajbcaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajiccabaaa
adaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "gles " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_11, tmpvar_11));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.xy = _glesMultiTexCoord0.xy;
  tmpvar_13.z = tmpvar_3.x;
  tmpvar_13.w = tmpvar_3.y;
  tmpvar_8 = -(tmpvar_13.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_8, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_9 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_12).xyz);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = normalize((tmpvar_10 - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  mediump vec3 normal_3;
  normal_3 = xlv_TEXCOORD4;
  mediump vec4 c_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(normal_3);
  normal_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = dot (tmpvar_5, normalize(_WorldSpaceLightPos0.xyz));
  c_4.xyz = ((color_2.xyz * _LightColor0.xyz) * (tmpvar_6 * 4.0));
  c_4.w = (tmpvar_6 * 4.0);
  mediump vec3 normal_7;
  normal_7 = xlv_TEXCOORD4;
  mediump float tmpvar_8;
  tmpvar_8 = dot (normal_7, normalize(_WorldSpaceLightPos0).xyz);
  color_2 = (c_4 * mix (1.0, clamp (
    floor((1.01 + tmpvar_8))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_8))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec3 t16_1;
mediump float t16_3;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    t16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_1.x = inversesqrt(t16_1.x);
    t16_1.xyz = t16_1.xxx * _WorldSpaceLightPos0.xyz;
    t0.xy = in_TEXCOORD0.xy;
    t0.z = in_TEXCOORD1.x;
    t6 = dot((-t0.xyz), t16_1.xyz);
    vs_TEXCOORD5.xyz = (-t0.xyz);
    t16_1.x = t6 + 1.00999999;
    t16_3 = t6 * -10.0;
    t16_3 = clamp(t16_3, 0.0, 1.0);
    t16_1.x = floor(t16_1.x);
    t16_1.x = clamp(t16_1.x, 0.0, 1.0);
    t16_1.x = t16_1.x + -1.0;
    t16_1.x = t16_3 * t16_1.x + 1.0;
    vs_TEXCOORD6 = t16_1.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
mediump float t16_6;
mediump float t16_9;
void main()
{
    t16_0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_0.x = inversesqrt(t16_0.x);
    t16_0.xyz = t16_0.xxx * _WorldSpaceLightPos0.xyz;
    t16_9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_9 = inversesqrt(t16_9);
    t16_1.xyz = vec3(t16_9) * vs_TEXCOORD4.xyz;
    t16_0.x = dot(t16_1.xyz, t16_0.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_0.xxx * t16_3.xyz;
    t16_0.x = t16_0.x * 4.0;
    t16_2.xyz = t16_3.xyz * vec3(4.0, 4.0, 4.0);
    t16_3.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, t16_3.xyz);
    t16_6 = t16_3.x + 1.00999999;
    t16_3.x = t16_3.x * -10.0;
    t16_3.x = clamp(t16_3.x, 0.0, 1.0);
    t16_6 = floor(t16_6);
    t16_6 = clamp(t16_6, 0.0, 1.0);
    t16_6 = t16_6 + -1.0;
    t16_3.x = t16_3.x * t16_6 + 1.0;
    t16_1.xyz = t16_3.xxx * t16_2.xyz;
    t16_0.w = t16_3.x * t16_0.x;
    t16_0.xyz = t16_0.www * t16_1.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 20 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 160
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
VectorHalf 16 [_WorldSpaceLightPos0] 4
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  half4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float3 lightDirection_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float3 tmpvar_6;
  float tmpvar_7;
  float3 tmpvar_8;
  tmpvar_8 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _mtl_i._glesNormal;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_6 = -(tmpvar_11.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = _mtl_i._glesNormal;
  half3 tmpvar_12;
  tmpvar_12 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_3 = float3(tmpvar_12);
  float tmpvar_13;
  tmpvar_13 = dot (tmpvar_6, lightDirection_3);
  NdotL_2 = half(tmpvar_13);
  half tmpvar_14;
  tmpvar_14 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_14);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_8 - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD4;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec3 t1;
vec4 t2;
vec3 t3;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t2.w = t3.x * 4.0;
    t2.xyz = t1.xyz * vec3(4.0, 4.0, 4.0);
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = ((float(
    (xlv_TEXCOORD2.z > 0.0)
  ) * texture2D (_LightTexture0, (
    (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w)
   + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz))).w);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0]
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
def c14, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4.xyz
dcl_texcoord5 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c12
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o7.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o4.xyz, r1.w, r1
nrm r1.xyz, c13
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o5.xyz, -r2
add r1.y, r1.x, c14.y
mul_sat r1.x, r1.x, c14.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c14.z
mad o6.x, r1.x, r1.y, c14.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
dp4 o3.w, c11, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 36 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefieceddbngblmgaedkadfbmiahlmcmgbobfahjabaaaaaaoeahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaaeaaaaaaaiahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
bcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadiccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaficcabaaa
acaaaaaadkaabaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaagaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
adaaaaaaegiocaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaaj
bcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaafaaaaaaegacbaiaebaaaaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
iccabaaaaeaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "gles " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp float tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_11, tmpvar_11));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.xy = _glesMultiTexCoord0.xy;
  tmpvar_13.z = tmpvar_3.x;
  tmpvar_13.w = tmpvar_3.y;
  tmpvar_8 = -(tmpvar_13.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_8, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_9 = tmpvar_15;
  tmpvar_7 = (_LightMatrix0 * tmpvar_10);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_12).xyz);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = normalize((tmpvar_10.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  mediump vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp vec3 LightCoord_6;
  LightCoord_6 = xlv_TEXCOORD2.xyz;
  highp float tmpvar_7;
  tmpvar_7 = dot (LightCoord_6, LightCoord_6);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2(tmpvar_7));
  mediump vec3 lightDir_9;
  lightDir_9 = tmpvar_3;
  mediump vec3 normal_10;
  normal_10 = xlv_TEXCOORD4;
  mediump float atten_11;
  atten_11 = ((float(
    (xlv_TEXCOORD2.z > 0.0)
  ) * tmpvar_4.w) * tmpvar_8.w);
  mediump vec4 c_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(lightDir_9);
  lightDir_9 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(normal_10);
  normal_10 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_13);
  c_12.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_15) * (atten_11 * 4.0));
  c_12.w = (tmpvar_15 * (atten_11 * 4.0));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  color_2 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump vec4 t16_2;
highp vec3 t3;
mediump float t16_6;
highp float t12;
highp float t13;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t12 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t12);
    t12 = inversesqrt(t12);
    vs_TEXCOORD7.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    t0.x = dot(t16_0, t1);
    t16_2.x = _LightMatrix0[0].y;
    t16_2.y = _LightMatrix0[1].y;
    t16_2.z = _LightMatrix0[2].y;
    t16_2.w = _LightMatrix0[3].y;
    t0.y = dot(t16_2, t1);
    t16_2.x = _LightMatrix0[0].z;
    t16_2.y = _LightMatrix0[1].z;
    t16_2.z = _LightMatrix0[2].z;
    t16_2.w = _LightMatrix0[3].z;
    t0.z = dot(t16_2, t1);
    t16_2.x = _LightMatrix0[0].w;
    t16_2.y = _LightMatrix0[1].w;
    t16_2.z = _LightMatrix0[2].w;
    t16_2.w = _LightMatrix0[3].w;
    t0.w = dot(t16_2, t1);
    vs_TEXCOORD2 = t0;
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    vs_TEXCOORD4.xyz = vec3(t13) * t1.xyz;
    t1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * _WorldSpaceLightPos0.xyz;
    t3.xy = in_TEXCOORD0.xy;
    t3.z = in_TEXCOORD1.x;
    t1.x = dot((-t3.xyz), t1.xyz);
    vs_TEXCOORD5.xyz = (-t3.xyz);
    t16_2.x = t1.x + 1.00999999;
    t16_6 = t1.x * -10.0;
    t16_6 = clamp(t16_6, 0.0, 1.0);
    t16_2.x = floor(t16_2.x);
    t16_2.x = clamp(t16_2.x, 0.0, 1.0);
    t16_2.x = t16_2.x + -1.0;
    t16_2.x = t16_6 * t16_2.x + 1.0;
    vs_TEXCOORD6 = t16_2.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
lowp float t10_1;
lowp float t10_2;
mediump vec3 t16_3;
highp vec3 t4;
mediump vec3 t16_5;
bool tb6;
mediump float t16_10;
highp float t16;
void main()
{
    t16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t16_0.xy = t16_0.xy + vec2(0.5, 0.5);
    t10_1 = texture(_LightTexture0, t16_0.xy).w;
    tb6 = 0.0<vs_TEXCOORD2.z;
    t10_2 = (tb6) ? 1.0 : 0.0;
    t10_2 = t10_1 * t10_2;
    t16_1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, t16_1.xx).w;
    t10_2 = t10_1 * t10_2;
    t16_0.x = t10_2 * 4.0;
    t16_5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_5.x = inversesqrt(t16_5.x);
    t16_5.xyz = t16_5.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * vs_TEXCOORD4.xyz;
    t16_5.x = dot(t16_3.xyz, t16_5.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_5.xxx * t16_3.xyz;
    t16_5.x = t16_0.x * t16_5.x;
    t16_1.xyz = t16_0.xxx * t16_3.xyz;
    t16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t16 = inversesqrt(t16);
    t4.xyz = vec3(t16) * _WorldSpaceLightPos0.xyz;
    t16_0.x = dot(vs_TEXCOORD4.xyz, t4.xyz);
    t16_10 = t16_0.x + 1.00999999;
    t16_0.x = t16_0.x * -10.0;
    t16_0.x = clamp(t16_0.x, 0.0, 1.0);
    t16_10 = floor(t16_10);
    t16_10 = clamp(t16_10, 0.0, 1.0);
    t16_10 = t16_10 + -1.0;
    t16_0.x = t16_0.x * t16_10 + 1.0;
    t16_3.xyz = t16_0.xxx * t16_1.xyz;
    t16_0.w = t16_0.x * t16_5.x;
    t16_0.xyz = t16_0.www * t16_3.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 21 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 192
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
MatrixHalf 160 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  half4 tmpvar_5;
  float3 tmpvar_6;
  float tmpvar_7;
  float4 tmpvar_8;
  tmpvar_8 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _mtl_i._glesNormal;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_6 = -(tmpvar_11.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_6, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_13);
  tmpvar_5 = half4(((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_8)));
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_8.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec3 vs_TEXCOORD4;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec4 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * _LightMatrix0[1];
    t1 = _LightMatrix0[0] * t0.xxxx + t1;
    t1 = _LightMatrix0[2] * t0.zzzz + t1;
    vs_TEXCOORD2 = _LightMatrix0[3] * t0.wwww + t1;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _LightTextureB0;
in  vec4 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec3 t1;
lowp vec4 t10_1;
vec4 t2;
vec2 t3;
bool tb3;
float t6;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t3.xy = t3.xy + vec2(0.5, 0.5);
    t10_1 = texture(_LightTexture0, t3.xy);
    tb3 = 0.0<vs_TEXCOORD2.z;
    t3.x = tb3 ? 1.0 : float(0.0);
    t3.x = t10_1.w * t3.x;
    t6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, vec2(t6));
    t3.x = t3.x * t10_1.w;
    t3.x = t3.x * 4.0;
    t6 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t6 = inversesqrt(t6);
    t1.xyz = vec3(t6) * _WorldSpaceLightPos0.xyz;
    t6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t6 = inversesqrt(t6);
    t2.xyz = vec3(t6) * vs_TEXCOORD4.xyz;
    t6 = dot(t2.xyz, t1.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = vec3(t6) * t1.xyz;
    t2.w = t3.x * t6;
    t2.xyz = t3.xxx * t1.xyz;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2))).w * textureCube (_LightTexture0, xlv_TEXCOORD2).w);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 39 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
"vs_3_0
def c13, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.xyz
dcl_texcoord5 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c11
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o7.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o4.xyz, r1.w, r1
nrm r1.xyz, c12
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o5.xyz, -r2
add r1.y, r1.x, c13.y
mul_sat r1.x, r1.x, c13.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c13.z
mad o6.x, r1.x, r1.y, c13.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 36 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecedncaejdjkmnpoaliildkofmfpochebapjabaaaaaaoeahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
bcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
iccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaficcabaaa
acaaaaaadkaabaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaafdcaabaaa
abaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaafaaaaaaegacbaiaebaaaaaaabaaaaaaaaaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_9).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD2);
  mediump vec3 lightDir_7;
  lightDir_7 = tmpvar_3;
  mediump vec3 normal_8;
  normal_8 = xlv_TEXCOORD4;
  mediump float atten_9;
  atten_9 = (tmpvar_5.w * tmpvar_6.w);
  mediump vec4 c_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(lightDir_7);
  lightDir_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(normal_8);
  normal_8 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, tmpvar_11);
  c_10.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD4;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  color_2 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump float t16_2;
mediump float t16_5;
highp float t9;
highp float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t9 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t9);
    t9 = inversesqrt(t9);
    vs_TEXCOORD7.xyz = vec3(t9) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_2 = t0.x + 1.00999999;
    t16_5 = t0.x * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2 = floor(t16_2);
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_2 = t16_2 + -1.0;
    t16_2 = t16_5 * t16_2 + 1.0;
    vs_TEXCOORD6 = t16_2;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].z;
    t16_0.y = _LightMatrix0[1].z;
    t16_0.z = _LightMatrix0[2].z;
    t16_0.w = _LightMatrix0[3].z;
    vs_TEXCOORD2.z = dot(t16_0, t1);
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    vs_TEXCOORD4.xyz = vec3(t10) * t1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
highp float t2;
mediump vec3 t16_2;
lowp float t10_2;
highp vec3 t3;
mediump vec3 t16_4;
lowp float t10_6;
mediump float t16_8;
mediump float t16_12;
highp float t14;
void main()
{
    t16_0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_0.x = inversesqrt(t16_0.x);
    t16_0.xyz = t16_0.xxx * _WorldSpaceLightPos0.xyz;
    t16_12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_12 = inversesqrt(t16_12);
    t16_1.xyz = vec3(t16_12) * vs_TEXCOORD4.xyz;
    t16_0.x = dot(t16_1.xyz, t16_0.xyz);
    t16_4.xyz = _LightColor0.xyz * _Color.xyz;
    t16_4.xyz = t16_0.xxx * t16_4.xyz;
    t2 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_2 = texture(_LightTextureB0, vec2(t2)).w;
    t10_6 = texture(_LightTexture0, vs_TEXCOORD2.xyz).w;
    t16_2.x = t10_6 * t10_2;
    t16_1.x = t16_2.x * 4.0;
    t16_2.xyz = t16_4.xyz * t16_1.xxx;
    t16_0.x = t16_0.x * t16_1.x;
    t14 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t14 = inversesqrt(t14);
    t3.xyz = vec3(t14) * _WorldSpaceLightPos0.xyz;
    t16_4.x = dot(vs_TEXCOORD4.xyz, t3.xyz);
    t16_8 = t16_4.x + 1.00999999;
    t16_4.x = t16_4.x * -10.0;
    t16_4.x = clamp(t16_4.x, 0.0, 1.0);
    t16_8 = floor(t16_8);
    t16_8 = clamp(t16_8, 0.0, 1.0);
    t16_8 = t16_8 + -1.0;
    t16_4.x = t16_4.x * t16_8 + 1.0;
    t16_1.xyz = t16_4.xxx * t16_2.xyz;
    t16_0.w = t16_4.x * t16_0.x;
    t16_0.xyz = t16_0.www * t16_1.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 21 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 192
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
MatrixHalf 160 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  float3 tmpvar_5;
  float tmpvar_6;
  float4 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _mtl_i._glesNormal;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_5 = -(tmpvar_10.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_11);
  half tmpvar_12;
  tmpvar_12 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_12);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_7)).xyz;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xyz = t0.yyy * _LightMatrix0[1].xyz;
    t1.xyz = _LightMatrix0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = _LightMatrix0[2].xyz * t0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _LightMatrix0[3].xyz * t0.www + t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTextureB0;
uniform  samplerCube _LightTexture0;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
lowp vec4 t10_2;
lowp vec4 t10_3;
vec3 t4;
float t8;
mediump float t16_8;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t4.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t4.x = floor(t4.x);
    t4.x = clamp(t4.x, 0.0, 1.0);
    t4.x = t4.x + -1.0;
    t0.x = t0.x * t4.x + 1.0;
    t4.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t4.x = inversesqrt(t4.x);
    t4.xyz = t4.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t4.x = dot(t1.xyz, t4.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t4.xxx * t1.xyz;
    t8 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_2 = texture(_LightTextureB0, vec2(t8));
    t10_3 = texture(_LightTexture0, vs_TEXCOORD2.xyz);
    t16_8 = t10_2.w * t10_3.w;
    t16_8 = t16_8 * 4.0;
    t1.xyz = vec3(t16_8) * t1.xyz;
    t1.w = t16_8 * t4.x;
    t0 = t0.xxxx * t1;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xy;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = texture2D (_LightTexture0, xlv_TEXCOORD2).w;
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 38 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 2
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
"vs_3_0
def c12, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xy
dcl_texcoord4 o4.xyz
dcl_texcoord5 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c10
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o7.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o4.xyz, r1.w, r1
nrm r1.xyz, c11
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o5.xyz, -r2
add r1.y, r1.x, c12.y
mul_sat r1.x, r1.x, c12.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c12.z
mad o6.x, r1.x, r1.y, c12.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 36 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecednnjhafjckdijeajlkjbbcfijbjpjafagabaaaaaaoeahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaealaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
bcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
eccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaficcabaaa
acaaaaaadkaabaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaahaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaa
baaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaafdcaabaaa
abaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaafaaaaaaegacbaiaebaaaaaaabaaaaaaaaaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajeccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp float tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_11, tmpvar_11));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.xy = _glesMultiTexCoord0.xy;
  tmpvar_13.z = tmpvar_3.x;
  tmpvar_13.w = tmpvar_3.y;
  tmpvar_8 = -(tmpvar_13.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_8, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_9 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_10).xy;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_12).xyz);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = normalize((tmpvar_10.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  mediump vec3 normal_4;
  normal_4 = xlv_TEXCOORD4;
  mediump float atten_5;
  atten_5 = tmpvar_3.w;
  mediump vec4 c_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(normal_4);
  normal_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  c_6.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_5 * 4.0));
  c_6.w = (tmpvar_8 * (atten_5 * 4.0));
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
  mediump float tmpvar_10;
  tmpvar_10 = dot (normal_9, normalize(_WorldSpaceLightPos0).xyz);
  color_2 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_10))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_10))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_1;
mediump float t16_3;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t16_1.x = _LightMatrix0[0].x;
    t16_1.y = _LightMatrix0[1].x;
    t16_1.z = _LightMatrix0[2].x;
    t16_1.w = _LightMatrix0[3].x;
    vs_TEXCOORD2.x = dot(t16_1, t0);
    t16_1.x = _LightMatrix0[0].y;
    t16_1.y = _LightMatrix0[1].y;
    t16_1.z = _LightMatrix0[2].y;
    t16_1.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_1, t0);
    t16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_1.x = inversesqrt(t16_1.x);
    t16_1.xyz = t16_1.xxx * _WorldSpaceLightPos0.xyz;
    t0.xy = in_TEXCOORD0.xy;
    t0.z = in_TEXCOORD1.x;
    t6 = dot((-t0.xyz), t16_1.xyz);
    vs_TEXCOORD5.xyz = (-t0.xyz);
    t16_1.x = t6 + 1.00999999;
    t16_3 = t6 * -10.0;
    t16_3 = clamp(t16_3, 0.0, 1.0);
    t16_1.x = floor(t16_1.x);
    t16_1.x = clamp(t16_1.x, 0.0, 1.0);
    t16_1.x = t16_1.x + -1.0;
    t16_1.x = t16_3 * t16_1.x + 1.0;
    vs_TEXCOORD6 = t16_1.x;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
mediump vec4 t16_1;
mediump vec3 t16_2;
lowp float t10_2;
mediump vec3 t16_3;
mediump float t16_6;
void main()
{
    t16_0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t16_0.x = inversesqrt(t16_0.x);
    t16_0.xyz = t16_0.xxx * _WorldSpaceLightPos0.xyz;
    t16_0.x = dot(vs_TEXCOORD4.xyz, t16_0.xyz);
    t16_3.x = t16_0.x + 1.00999999;
    t16_0.x = t16_0.x * -10.0;
    t16_0.x = clamp(t16_0.x, 0.0, 1.0);
    t16_3.x = floor(t16_3.x);
    t16_3.x = clamp(t16_3.x, 0.0, 1.0);
    t16_3.x = t16_3.x + -1.0;
    t16_0.x = t16_0.x * t16_3.x + 1.0;
    t16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * _WorldSpaceLightPos0.xyz;
    t16_1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_1.x = inversesqrt(t16_1.x);
    t16_1.xyz = t16_1.xxx * vs_TEXCOORD4.xyz;
    t16_3.x = dot(t16_1.xyz, t16_3.xyz);
    t16_1.xyz = _LightColor0.xyz * _Color.xyz;
    t16_1.xyz = t16_3.xxx * t16_1.xyz;
    t10_2 = texture(_LightTexture0, vs_TEXCOORD2.xy).w;
    t16_6 = t10_2 * 4.0;
    t16_2.xyz = vec3(t16_6) * t16_1.xyz;
    t16_3.x = t16_6 * t16_3.x;
    t16_1.w = t16_0.x * t16_3.x;
    t16_0.xyz = t16_0.xxx * t16_2.xyz;
    t16_1.xyz = t16_1.www * t16_0.xyz;
    SV_Target0 = t16_1;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 21 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 192
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
MatrixHalf 160 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
VectorHalf 16 [_WorldSpaceLightPos0] 4
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float2 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  half4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float3 lightDirection_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float3 tmpvar_6;
  float tmpvar_7;
  float4 tmpvar_8;
  tmpvar_8 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _mtl_i._glesNormal;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_6 = -(tmpvar_11.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = _mtl_i._glesNormal;
  half3 tmpvar_12;
  tmpvar_12 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_3 = float3(tmpvar_12);
  float tmpvar_13;
  tmpvar_13 = dot (tmpvar_6, lightDirection_3);
  NdotL_2 = half(tmpvar_13);
  half tmpvar_14;
  tmpvar_14 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_14);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_8)).xy;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_8.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec2 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xy = t0.yy * _LightMatrix0[1].xy;
    t0.xy = _LightMatrix0[0].xy * t0.xx + t1.xy;
    t0.xy = _LightMatrix0[2].xy * t0.zz + t0.xy;
    vs_TEXCOORD2.xy = _LightMatrix0[3].xy * t0.ww + t0.xy;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
in  vec2 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
lowp vec4 t10_2;
vec3 t3;
mediump float t16_6;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t10_2 = texture(_LightTexture0, vs_TEXCOORD2.xy);
    t16_6 = t10_2.w * 4.0;
    t1.xyz = vec3(t16_6) * t1.xyz;
    t1.w = t16_6 * t3.x;
    t0 = t0.xxxx * t1;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_9, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_16;
  tmpvar_7 = (_LightMatrix0 * tmpvar_11);
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  mediump vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp vec3 LightCoord_6;
  LightCoord_6 = xlv_TEXCOORD2.xyz;
  highp float tmpvar_7;
  tmpvar_7 = dot (LightCoord_6, LightCoord_6);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2(tmpvar_7));
  lowp float tmpvar_9;
  highp vec4 shadowCoord_10;
  shadowCoord_10 = xlv_TEXCOORD3;
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, shadowCoord_10);
  mediump float tmpvar_12;
  if ((tmpvar_11.x < (shadowCoord_10.z / shadowCoord_10.w))) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  tmpvar_9 = tmpvar_12;
  mediump vec3 lightDir_13;
  lightDir_13 = tmpvar_3;
  mediump vec3 normal_14;
  normal_14 = xlv_TEXCOORD4;
  mediump float atten_15;
  atten_15 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * tmpvar_4.w) * tmpvar_8.w) * tmpvar_9);
  mediump vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(lightDir_13);
  lightDir_13 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(normal_14);
  normal_14 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, tmpvar_17);
  c_16.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_19) * (atten_15 * 4.0));
  c_16.w = (tmpvar_19 * (atten_15 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  color_2 = (c_16 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "opengl " {
// Stats: 31 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * tmpvar_3);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightShadowData;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz))).w) * (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x * 
    (1.0 - _LightShadowData.x)
  )));
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 44 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 12 [_LightMatrix0]
Matrix 8 [_Object2World]
Matrix 4 [glstate_matrix_mvp]
Matrix 0 [unity_World2Shadow0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
"vs_3_0
def c18, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, r0, -c16
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c8, v2
dp3 r1.y, c9, v2
dp3 r1.z, c10, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c17
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c18.y
mul_sat r1.x, r1.x, c18.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c18.z
mad o7.x, r1.x, r1.y, c18.w
dp4 r0.w, c11, v0
dp4 o3.x, c12, r0
dp4 o3.y, c13, r0
dp4 o3.z, c14, r0
dp4 o3.w, c15, r0
dp4 o4.x, c0, r0
dp4 o4.y, c1, r0
dp4 o4.z, c2, r0
dp4 o4.w, c3, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 40 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
root12:aaafaaaa
eefiecedjhlpbmclikgiblknliknibnphhdhhepkabaaaaaalaaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaaiahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleagaaaaeaaaabaa
knabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
amaaaaaafjaaaaaeegiocaaaaeaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
iccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaelaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaahaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaafaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
// Stats: 31 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_9, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_16;
  tmpvar_7 = (_LightMatrix0 * tmpvar_11);
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  mediump vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  highp vec4 shadowCoord_9;
  shadowCoord_9 = xlv_TEXCOORD3;
  mediump float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DProjEXT (_ShadowMapTexture, shadowCoord_9);
  mediump float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  shadow_10 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  tmpvar_8 = shadow_10;
  mediump vec3 lightDir_13;
  lightDir_13 = tmpvar_3;
  mediump vec3 normal_14;
  normal_14 = xlv_TEXCOORD4;
  mediump float atten_15;
  atten_15 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(lightDir_13);
  lightDir_13 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(normal_14);
  normal_14 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, tmpvar_17);
  c_16.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_19) * (atten_15 * 4.0));
  c_16.w = (tmpvar_19 * (atten_15 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  color_2 = (c_16 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump vec4 t16_2;
highp vec3 t3;
mediump float t16_6;
highp float t12;
highp float t13;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t12 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t12);
    t12 = inversesqrt(t12);
    vs_TEXCOORD7.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    t0.x = dot(t16_0, t1);
    t16_2.x = _LightMatrix0[0].y;
    t16_2.y = _LightMatrix0[1].y;
    t16_2.z = _LightMatrix0[2].y;
    t16_2.w = _LightMatrix0[3].y;
    t0.y = dot(t16_2, t1);
    t16_2.x = _LightMatrix0[0].z;
    t16_2.y = _LightMatrix0[1].z;
    t16_2.z = _LightMatrix0[2].z;
    t16_2.w = _LightMatrix0[3].z;
    t0.z = dot(t16_2, t1);
    t16_2.x = _LightMatrix0[0].w;
    t16_2.y = _LightMatrix0[1].w;
    t16_2.z = _LightMatrix0[2].w;
    t16_2.w = _LightMatrix0[3].w;
    t0.w = dot(t16_2, t1);
    vs_TEXCOORD2 = t0;
    t0 = t1.yyyy * unity_World2Shadow[0][1];
    t0 = unity_World2Shadow[0][0] * t1.xxxx + t0;
    t0 = unity_World2Shadow[0][2] * t1.zzzz + t0;
    t0 = unity_World2Shadow[0][3] * t1.wwww + t0;
    vs_TEXCOORD3 = t0;
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    vs_TEXCOORD4.xyz = vec3(t13) * t1.xyz;
    t1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * _WorldSpaceLightPos0.xyz;
    t3.xy = in_TEXCOORD0.xy;
    t3.z = in_TEXCOORD1.x;
    t1.x = dot((-t3.xyz), t1.xyz);
    vs_TEXCOORD5.xyz = (-t3.xyz);
    t16_2.x = t1.x + 1.00999999;
    t16_6 = t1.x * -10.0;
    t16_6 = clamp(t16_6, 0.0, 1.0);
    t16_2.x = floor(t16_2.x);
    t16_2.x = clamp(t16_2.x, 0.0, 1.0);
    t16_2.x = t16_2.x + -1.0;
    t16_2.x = t16_6 * t16_2.x + 1.0;
    vs_TEXCOORD6 = t16_2.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
lowp float t10_1;
lowp float t10_2;
mediump vec3 t16_3;
highp vec3 t4;
mediump vec3 t16_5;
bool tb6;
mediump float t16_10;
highp float t16;
void main()
{
    t16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t16_0.xy = t16_0.xy + vec2(0.5, 0.5);
    t10_1 = texture(_LightTexture0, t16_0.xy).w;
    tb6 = 0.0<vs_TEXCOORD2.z;
    t10_2 = (tb6) ? 1.0 : 0.0;
    t10_2 = t10_1 * t10_2;
    t16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, t16_0.xx).w;
    t10_2 = t10_1 * t10_2;
    t16_1.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    vec3 txVec37 = vec3(t16_1.xy,t16_1.z);
    t10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec37, 0.0);
    t16_0.x = (-_LightShadowData.x) + 1.0;
    t16_0.x = t10_1 * t16_0.x + _LightShadowData.x;
    t10_2 = t16_0.x * t10_2;
    t16_0.x = t10_2 * 4.0;
    t16_5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_5.x = inversesqrt(t16_5.x);
    t16_5.xyz = t16_5.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * vs_TEXCOORD4.xyz;
    t16_5.x = dot(t16_3.xyz, t16_5.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_5.xxx * t16_3.xyz;
    t16_5.x = t16_0.x * t16_5.x;
    t16_1.xyz = t16_0.xxx * t16_3.xyz;
    t16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t16 = inversesqrt(t16);
    t4.xyz = vec3(t16) * _WorldSpaceLightPos0.xyz;
    t16_0.x = dot(vs_TEXCOORD4.xyz, t4.xyz);
    t16_10 = t16_0.x + 1.00999999;
    t16_0.x = t16_0.x * -10.0;
    t16_0.x = clamp(t16_0.x, 0.0, 1.0);
    t16_10 = floor(t16_10);
    t16_10 = clamp(t16_10, 0.0, 1.0);
    t16_10 = t16_10 + -1.0;
    t16_0.x = t16_0.x * t16_10 + 1.0;
    t16_3.xyz = t16_0.xxx * t16_1.xyz;
    t16_0.w = t16_0.x * t16_5.x;
    t16_0.xyz = t16_0.www * t16_3.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 448
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [_Object2World]
MatrixHalf 416 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  half4 tmpvar_5;
  half4 tmpvar_6;
  float3 tmpvar_7;
  float tmpvar_8;
  float4 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_10, tmpvar_10));
  float4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _mtl_i._glesNormal;
  float4 tmpvar_12;
  tmpvar_12.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_12.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_12.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_13);
  half tmpvar_14;
  tmpvar_14 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_8 = float(tmpvar_14);
  tmpvar_5 = half4(((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_9)));
  tmpvar_6 = half4((_mtl_u.unity_World2Shadow[0] * tmpvar_9));
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_11).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec4 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * _LightMatrix0[1];
    t1 = _LightMatrix0[0] * t0.xxxx + t1;
    t1 = _LightMatrix0[2] * t0.zzzz + t1;
    vs_TEXCOORD2 = _LightMatrix0[3] * t0.wwww + t1;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    vs_TEXCOORD3 = unity_World2Shadow[0][3] * t0.wwww + t1;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _LightTextureB0;
uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform  sampler2D _ShadowMapTexture;
in  vec4 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec3 t1;
lowp vec4 t10_1;
vec4 t2;
vec2 t3;
bool tb3;
float t6;
lowp float t10_6;
float t9;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t3.xy = t3.xy + vec2(0.5, 0.5);
    t10_1 = texture(_LightTexture0, t3.xy);
    tb3 = 0.0<vs_TEXCOORD2.z;
    t3.x = tb3 ? 1.0 : float(0.0);
    t3.x = t10_1.w * t3.x;
    t6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, vec2(t6));
    t3.x = t3.x * t10_1.w;
    t1.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    vec3 txVec39 = vec3(t1.xy,t1.z);
    t10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec39, 0.0);
    t9 = (-_LightShadowData.x) + 1.0;
    t6 = t10_6 * t9 + _LightShadowData.x;
    t3.x = t6 * t3.x;
    t3.x = t3.x * 4.0;
    t6 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t6 = inversesqrt(t6);
    t1.xyz = vec3(t6) * _WorldSpaceLightPos0.xyz;
    t6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t6 = inversesqrt(t6);
    t2.xyz = vec3(t6) * vs_TEXCOORD4.xyz;
    t6 = dot(t2.xyz, t1.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = vec3(t6) * t1.xyz;
    t2.w = t3.x * t6;
    t2.xyz = t3.xxx * t1.xyz;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  tmpvar_2.w = sqrt(dot (tmpvar_5, tmpvar_5));
  vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = gl_Normal;
  vec4 tmpvar_7;
  tmpvar_7.xy = gl_MultiTexCoord0.xy;
  tmpvar_7.z = gl_MultiTexCoord1.x;
  tmpvar_7.w = gl_MultiTexCoord1.y;
  tmpvar_3 = -(tmpvar_7.xyz);
  tmpvar_2.xyz = gl_Normal;
  float tmpvar_8;
  tmpvar_8 = dot (tmpvar_3, normalize(_WorldSpaceLightPos0.xyz));
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_1 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_6).xyz);
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_8)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_8)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (tmpvar_2.x * 4.0));
  c_3.w = (tmpvar_4 * (tmpvar_2.x * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 7 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
"vs_3_0
def c11, -10, 1.00999999, -1, 1
def c12, 0.5, 0, 0, 0
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4.xyz
dcl_texcoord5 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7.xyz
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r0.xyz, r0, -c7
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp o2.w, r0.w
mul o7.xyz, r0.w, r0
dp3 r0.x, c4, v2
dp3 r0.y, c5, v2
dp3 r0.z, c6, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
nrm r0.xyz, c10
mov r1.xy, v3
mov r1.z, v4.x
dp3 r0.x, -r1, r0
mov o5.xyz, -r1
add r0.y, r0.x, c11.y
mul_sat r0.x, r0.x, c11.x
frc r0.z, r0.y
add_sat r0.y, -r0.z, r0.y
add r0.y, r0.y, c11.z
mad o6.x, r0.x, r0.y, c11.w
dp4 r0.y, c1, v0
mul r1.x, r0.y, c8.x
mul r1.w, r1.x, c12.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c12.x
mad o3.xy, r1.z, c9.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o3.zw, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 31 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecediihnjeclhibiblblfeffhohdgapphcfaabaaaaaadaahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaaeaaaaaaaiahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
emafaaaaeaaaabaafdabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadiccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
iccabaaaacaaaaaadkaabaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaagaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaafaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaaeaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_9, lightDirection_5);
  NdotL_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_17;
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), _LightShadowData.x);
  tmpvar_3 = tmpvar_4;
  mediump vec3 normal_5;
  normal_5 = xlv_TEXCOORD4;
  mediump float atten_6;
  atten_6 = tmpvar_3;
  mediump vec4 c_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_6 * 4.0));
  c_7.w = (tmpvar_9 * (atten_6 * 4.0));
  mediump vec3 normal_10;
  normal_10 = xlv_TEXCOORD4;
  mediump float tmpvar_11;
  tmpvar_11 = dot (normal_10, normalize(_WorldSpaceLightPos0).xyz);
  color_2 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_11))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_11))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec3 vs_TEXCOORD4;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec4 t1;
float t2;
float t6;
float t7;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0 = in_COLOR0;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t1.xyz = t1.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t7 = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t7);
    t7 = inversesqrt(t7);
    vs_TEXCOORD7.xyz = vec3(t7) * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = t0.zw;
    vs_TEXCOORD2.xy = t1.zz + t1.xw;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _ShadowMapTexture;
in  vec4 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
lowp vec4 t10_2;
vec3 t3;
vec2 t6;
mediump float t16_6;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t10_2 = texture(_ShadowMapTexture, t6.xy);
    t16_6 = t10_2.x * 4.0;
    t1.xyz = vec3(t16_6) * t1.xyz;
    t1.w = t16_6 * t3.x;
    t0 = t0.xxxx * t1;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 21 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex);
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4.xyz - _WorldSpaceCameraPos);
  tmpvar_2.w = sqrt(dot (tmpvar_5, tmpvar_5));
  vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = gl_Normal;
  vec4 tmpvar_7;
  tmpvar_7.xy = gl_MultiTexCoord0.xy;
  tmpvar_7.z = gl_MultiTexCoord1.x;
  tmpvar_7.w = gl_MultiTexCoord1.y;
  tmpvar_3 = -(tmpvar_7.xyz);
  tmpvar_2.xyz = gl_Normal;
  float tmpvar_8;
  tmpvar_8 = dot (tmpvar_3, normalize(_WorldSpaceLightPos0.xyz));
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_1 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_4).xy;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_6).xyz);
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_8)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_8)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_4.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = (texture2D (_LightTexture0, xlv_TEXCOORD2).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 44 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 2
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
def c14, -10, 1.00999999, -1, 1
def c15, 0.5, 0, 0, 0
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xy
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c10
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c13
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c14.y
mul_sat r1.x, r1.x, c14.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c14.z
mad o7.x, r1.x, r1.y, c14.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c15.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c15.x
mad o4.xy, r1.z, c12.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 39 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecedmicepbmheobjmlpgocbfnnbhedhiaheiabaaaaaajeaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaealaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiagaaaaeaaaabaa
kgabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadeccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaacaaaaaadkaabaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
ahaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaacaaaaaa
egbcbaaaacaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaidcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaahaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaagaaaaaaagaabaaaabaaaaaa
egaabaaaacaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaakdccabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaapgapbaaaabaaaaaaegaabaaaabaaaaaabaaaaaajbcaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaafdcaabaaaacaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaacaaaaaaakbabaaaaeaaaaaabaaaaaaibcaabaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
agaaaaaaegacbaiaebaaaaaaacaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaacambebcaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaialpdcaaaaajeccabaaa
adaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_9, lightDirection_5);
  NdotL_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_17;
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_11).xy;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  lowp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), _LightShadowData.x);
  tmpvar_4 = tmpvar_5;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD4;
  mediump float atten_7;
  atten_7 = (tmpvar_3.w * tmpvar_4);
  mediump vec4 c_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(normal_6);
  normal_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, normalize(_WorldSpaceLightPos0.xyz));
  c_8.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_10) * (atten_7 * 4.0));
  c_8.w = (tmpvar_10 * (atten_7 * 4.0));
  mediump vec3 normal_11;
  normal_11 = xlv_TEXCOORD4;
  mediump float tmpvar_12;
  tmpvar_12 = dot (normal_11, normalize(_WorldSpaceLightPos0).xyz);
  color_2 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_12))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_12))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec2 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec4 t1;
vec3 t2;
float t4;
float t9;
float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0 = in_COLOR0;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t1.xyz = t1.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t10 = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t10);
    t10 = inversesqrt(t10);
    vs_TEXCOORD7.xyz = vec3(t10) * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    t2.xy = t1.yy * _LightMatrix0[1].xy;
    t1.xy = _LightMatrix0[0].xy * t1.xx + t2.xy;
    t1.xy = _LightMatrix0[2].xy * t1.zz + t1.xy;
    vs_TEXCOORD2.xy = _LightMatrix0[3].xy * t1.ww + t1.xy;
    t1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * _WorldSpaceLightPos0.xyz;
    t2.xy = in_TEXCOORD0.xy;
    t2.z = in_TEXCOORD1.x;
    t1.x = dot((-t2.xyz), t1.xyz);
    vs_TEXCOORD5.xyz = (-t2.xyz);
    t4 = t1.x + 1.00999999;
    t1.x = t1.x * -10.0;
    t1.x = clamp(t1.x, 0.0, 1.0);
    t4 = floor(t4);
    t4 = clamp(t4, 0.0, 1.0);
    t4 = t4 + -1.0;
    vs_TEXCOORD6 = t1.x * t4 + 1.0;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = t0.zw;
    vs_TEXCOORD3.xy = t1.zz + t1.xw;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t9 = dot(t0.xyz, t0.xyz);
    t9 = inversesqrt(t9);
    vs_TEXCOORD4.xyz = vec3(t9) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _ShadowMapTexture;
in  vec2 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
lowp vec4 t10_2;
lowp vec4 t10_3;
vec3 t4;
vec2 t8;
mediump float t16_8;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t4.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t4.x = floor(t4.x);
    t4.x = clamp(t4.x, 0.0, 1.0);
    t4.x = t4.x + -1.0;
    t0.x = t0.x * t4.x + 1.0;
    t4.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t4.x = inversesqrt(t4.x);
    t4.xyz = t4.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t4.x = dot(t1.xyz, t4.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t4.xxx * t1.xyz;
    t8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    t10_2 = texture(_ShadowMapTexture, t8.xy);
    t10_3 = texture(_LightTexture0, vs_TEXCOORD2.xy);
    t16_8 = t10_2.x * t10_3.w;
    t16_8 = t16_8 * 4.0;
    t1.xyz = vec3(t16_8) * t1.xyz;
    t1.w = t16_8 * t4.x;
    t0 = t0.xxxx * t1;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 28 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xyz;
  xlv_TEXCOORD3 = (tmpvar_3.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)));
  float mydist_3;
  mydist_3 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_4;
  tmpvar_4 = textureCube (_ShadowMapTexture, xlv_TEXCOORD3);
  float tmpvar_5;
  if ((tmpvar_4.x < mydist_3)) {
    tmpvar_5 = _LightShadowData.x;
  } else {
    tmpvar_5 = 1.0;
  };
  float atten_6;
  atten_6 = (tmpvar_2.w * tmpvar_5);
  vec4 c_7;
  float tmpvar_8;
  tmpvar_8 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 4.0));
  c_7.w = (tmpvar_8 * (atten_6 * 4.0));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_9))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_9))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_LightPositionRange]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
"vs_3_0
def c14, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c11
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c12
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c14.y
mul_sat r1.x, r1.x, c14.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c14.z
mad o7.x, r1.x, r1.y, c14.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
add o4.xyz, r0, -c13
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecednjiafaehceelhfdjldhgjnbjolnaneimabaaaaaacmaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaahaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 29 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_9).xyz;
  xlv_TEXCOORD3 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  highp float mydist_6;
  mydist_6 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_7;
  tmpvar_7 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD3), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_8;
  if ((tmpvar_7 < mydist_6)) {
    tmpvar_8 = _LightShadowData.x;
  } else {
    tmpvar_8 = 1.0;
  };
  mediump vec3 lightDir_9;
  lightDir_9 = tmpvar_3;
  mediump vec3 normal_10;
  normal_10 = xlv_TEXCOORD4;
  mediump float atten_11;
  atten_11 = (tmpvar_5.w * tmpvar_8);
  mediump vec4 c_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(lightDir_9);
  lightDir_9 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(normal_10);
  normal_10 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_13);
  c_12.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_15) * (atten_11 * 4.0));
  c_12.w = (tmpvar_15 * (atten_11 * 4.0));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  color_2 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump float t16_2;
mediump float t16_5;
highp float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_2 = t0.x + 1.00999999;
    t16_5 = t0.x * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2 = floor(t16_2);
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_2 = t16_2 + -1.0;
    t16_2 = t16_5 * t16_2 + 1.0;
    vs_TEXCOORD6 = t16_2;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].z;
    t16_0.y = _LightMatrix0[1].z;
    t16_0.z = _LightMatrix0[2].z;
    t16_0.w = _LightMatrix0[3].z;
    vs_TEXCOORD2.z = dot(t16_0, t1);
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    vs_TEXCOORD4.xyz = vec3(t10) * t1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
uniform highp samplerCube _ShadowMapTexture;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp float t0;
mediump vec4 t16_0;
lowp float t10_0;
bool tb0;
highp vec4 t1;
mediump float t16_2;
mediump vec3 t16_3;
highp float t4;
mediump vec3 t16_6;
mediump float t16_10;
highp float t12;
void main()
{
    t0 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t0 = sqrt(t0);
    t0 = t0 * _LightPositionRange.w;
    t0 = t0 * 0.970000029;
    t1 = texture(_ShadowMapTexture, vs_TEXCOORD3.xyz);
    t4 = dot(t1, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    tb0 = t4<t0;
    t16_2 = (tb0) ? _LightShadowData.x : 1.0;
    t0 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_0 = texture(_LightTexture0, vec2(t0)).w;
    t16_0.x = t16_2 * t10_0;
    t16_2 = t16_0.x * 4.0;
    t16_6.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_6.x = inversesqrt(t16_6.x);
    t16_6.xyz = t16_6.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * vs_TEXCOORD4.xyz;
    t16_6.x = dot(t16_3.xyz, t16_6.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_6.xxx * t16_3.xyz;
    t16_6.x = t16_2 * t16_6.x;
    t16_0.xyz = vec3(t16_2) * t16_3.xyz;
    t12 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t12 = inversesqrt(t12);
    t1.xyz = vec3(t12) * _WorldSpaceLightPos0.xyz;
    t16_2 = dot(vs_TEXCOORD4.xyz, t1.xyz);
    t16_10 = t16_2 + 1.00999999;
    t16_2 = t16_2 * -10.0;
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_10 = floor(t16_10);
    t16_10 = clamp(t16_10, 0.0, 1.0);
    t16_10 = t16_10 + -1.0;
    t16_2 = t16_2 * t16_10 + 1.0;
    t16_3.xyz = t16_0.xyz * vec3(t16_2);
    t16_0.w = t16_2 * t16_6.x;
    t16_0.xyz = t16_0.www * t16_3.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 208
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
MatrixHalf 176 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
Vector 32 [_LightPositionRange]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  float3 tmpvar_5;
  float tmpvar_6;
  float4 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _mtl_i._glesNormal;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_5 = -(tmpvar_10.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_11);
  half tmpvar_12;
  tmpvar_12 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_12);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_7)).xyz;
  _mtl_o.xlv_TEXCOORD3 = (tmpvar_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xyz = t0.yyy * _LightMatrix0[1].xyz;
    t1.xyz = _LightMatrix0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = _LightMatrix0[2].xyz * t0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _LightMatrix0[3].xyz * t0.www + t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
uniform  samplerCube _ShadowMapTexture;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec3 t1;
lowp vec4 t10_1;
vec4 t2;
float t3;
bool tb3;
float t6;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3 = floor(t3);
    t3 = clamp(t3, 0.0, 1.0);
    t3 = t3 + -1.0;
    t0.x = t0.x * t3 + 1.0;
    t3 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t3 = sqrt(t3);
    t3 = t3 * _LightPositionRange.w;
    t3 = t3 * 0.970000029;
    t10_1 = texture(_ShadowMapTexture, vs_TEXCOORD3.xyz);
    tb3 = t10_1.x<t3;
    t3 = (tb3) ? _LightShadowData.x : 1.0;
    t6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTexture0, vec2(t6));
    t3 = t3 * t10_1.w;
    t3 = t3 * 4.0;
    t6 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t6 = inversesqrt(t6);
    t1.xyz = vec3(t6) * _WorldSpaceLightPos0.xyz;
    t6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t6 = inversesqrt(t6);
    t2.xyz = vec3(t6) * vs_TEXCOORD4.xyz;
    t6 = dot(t2.xyz, t1.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = vec3(t6) * t1.xyz;
    t2.w = t3 * t6;
    t2.xyz = vec3(t3) * t1.xyz;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 29 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xyz;
  xlv_TEXCOORD3 = (tmpvar_3.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)));
  vec4 tmpvar_3;
  tmpvar_3 = textureCube (_LightTexture0, xlv_TEXCOORD2);
  float mydist_4;
  mydist_4 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_5;
  tmpvar_5 = textureCube (_ShadowMapTexture, xlv_TEXCOORD3);
  float tmpvar_6;
  if ((tmpvar_5.x < mydist_4)) {
    tmpvar_6 = _LightShadowData.x;
  } else {
    tmpvar_6 = 1.0;
  };
  float atten_7;
  atten_7 = ((tmpvar_2.w * tmpvar_3.w) * tmpvar_6);
  vec4 c_8;
  float tmpvar_9;
  tmpvar_9 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_8.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_7 * 4.0));
  c_8.w = (tmpvar_9 * (atten_7 * 4.0));
  float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_10))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_10))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_LightPositionRange]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
"vs_3_0
def c14, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c11
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c12
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c14.y
mul_sat r1.x, r1.x, c14.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c14.z
mad o7.x, r1.x, r1.y, c14.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
add o4.xyz, r0, -c13
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecednjiafaehceelhfdjldhgjnbjolnaneimabaaaaaacmaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaahaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 30 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_9).xyz;
  xlv_TEXCOORD3 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD2);
  highp float mydist_7;
  mydist_7 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_8;
  tmpvar_8 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD3), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_9;
  if ((tmpvar_8 < mydist_7)) {
    tmpvar_9 = _LightShadowData.x;
  } else {
    tmpvar_9 = 1.0;
  };
  mediump vec3 lightDir_10;
  lightDir_10 = tmpvar_3;
  mediump vec3 normal_11;
  normal_11 = xlv_TEXCOORD4;
  mediump float atten_12;
  atten_12 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_9);
  mediump vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(lightDir_10);
  lightDir_10 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(normal_11);
  normal_11 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (tmpvar_15, tmpvar_14);
  c_13.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_16) * (atten_12 * 4.0));
  c_13.w = (tmpvar_16 * (atten_12 * 4.0));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_18;
  lightDir_18 = tmpvar_17;
  mediump vec3 normal_19;
  normal_19 = xlv_TEXCOORD4;
  mediump float tmpvar_20;
  tmpvar_20 = dot (normal_19, lightDir_18);
  color_2 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_20))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_20))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump float t16_2;
mediump float t16_5;
highp float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_2 = t0.x + 1.00999999;
    t16_5 = t0.x * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2 = floor(t16_2);
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_2 = t16_2 + -1.0;
    t16_2 = t16_5 * t16_2 + 1.0;
    vs_TEXCOORD6 = t16_2;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].z;
    t16_0.y = _LightMatrix0[1].z;
    t16_0.z = _LightMatrix0[2].z;
    t16_0.w = _LightMatrix0[3].z;
    vs_TEXCOORD2.z = dot(t16_0, t1);
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    vs_TEXCOORD4.xyz = vec3(t10) * t1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
uniform highp samplerCube _ShadowMapTexture;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp float t0;
mediump vec4 t16_0;
lowp float t10_0;
bool tb0;
highp vec4 t1;
mediump float t16_2;
mediump vec3 t16_3;
highp float t4;
lowp float t10_4;
mediump vec3 t16_6;
mediump float t16_10;
highp float t12;
void main()
{
    t0 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t0 = sqrt(t0);
    t0 = t0 * _LightPositionRange.w;
    t0 = t0 * 0.970000029;
    t1 = texture(_ShadowMapTexture, vs_TEXCOORD3.xyz);
    t4 = dot(t1, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    tb0 = t4<t0;
    t16_2 = (tb0) ? _LightShadowData.x : 1.0;
    t0 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_0 = texture(_LightTextureB0, vec2(t0)).w;
    t10_4 = texture(_LightTexture0, vs_TEXCOORD2.xyz).w;
    t16_0.x = t10_4 * t10_0;
    t16_0.x = t16_2 * t16_0.x;
    t16_2 = t16_0.x * 4.0;
    t16_6.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_6.x = inversesqrt(t16_6.x);
    t16_6.xyz = t16_6.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * vs_TEXCOORD4.xyz;
    t16_6.x = dot(t16_3.xyz, t16_6.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_6.xxx * t16_3.xyz;
    t16_6.x = t16_2 * t16_6.x;
    t16_0.xyz = vec3(t16_2) * t16_3.xyz;
    t12 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t12 = inversesqrt(t12);
    t1.xyz = vec3(t12) * _WorldSpaceLightPos0.xyz;
    t16_2 = dot(vs_TEXCOORD4.xyz, t1.xyz);
    t16_10 = t16_2 + 1.00999999;
    t16_2 = t16_2 * -10.0;
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_10 = floor(t16_10);
    t16_10 = clamp(t16_10, 0.0, 1.0);
    t16_10 = t16_10 + -1.0;
    t16_2 = t16_2 * t16_10 + 1.0;
    t16_3.xyz = t16_0.xyz * vec3(t16_2);
    t16_0.w = t16_2 * t16_6.x;
    t16_0.xyz = t16_0.www * t16_3.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 208
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
MatrixHalf 176 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
Vector 32 [_LightPositionRange]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  float3 tmpvar_5;
  float tmpvar_6;
  float4 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _mtl_i._glesNormal;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_5 = -(tmpvar_10.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_11);
  half tmpvar_12;
  tmpvar_12 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_12);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_7)).xyz;
  _mtl_o.xlv_TEXCOORD3 = (tmpvar_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xyz = t0.yyy * _LightMatrix0[1].xyz;
    t1.xyz = _LightMatrix0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = _LightMatrix0[2].xyz * t0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _LightMatrix0[3].xyz * t0.www + t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTextureB0;
uniform  samplerCube _LightTexture0;
uniform  samplerCube _ShadowMapTexture;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec3 t1;
lowp vec4 t10_1;
vec4 t2;
lowp vec4 t10_2;
float t3;
bool tb3;
float t6;
mediump float t16_6;
void main()
{
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3 = floor(t3);
    t3 = clamp(t3, 0.0, 1.0);
    t3 = t3 + -1.0;
    t0.x = t0.x * t3 + 1.0;
    t3 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t3 = sqrt(t3);
    t3 = t3 * _LightPositionRange.w;
    t3 = t3 * 0.970000029;
    t10_1 = texture(_ShadowMapTexture, vs_TEXCOORD3.xyz);
    tb3 = t10_1.x<t3;
    t3 = (tb3) ? _LightShadowData.x : 1.0;
    t6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, vec2(t6));
    t10_2 = texture(_LightTexture0, vs_TEXCOORD2.xyz);
    t16_6 = t10_1.w * t10_2.w;
    t3 = t3 * t16_6;
    t3 = t3 * 4.0;
    t6 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t6 = inversesqrt(t6);
    t1.xyz = vec3(t6) * _WorldSpaceLightPos0.xyz;
    t6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t6 = inversesqrt(t6);
    t2.xyz = vec3(t6) * vs_TEXCOORD4.xyz;
    t6 = dot(t2.xyz, t1.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = vec3(t6) * t1.xyz;
    t2.w = t3 * t6;
    t2.xyz = vec3(t3) * t1.xyz;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 39 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_9, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_16;
  tmpvar_7 = (_LightMatrix0 * tmpvar_11);
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  mediump vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp vec3 LightCoord_6;
  LightCoord_6 = xlv_TEXCOORD2.xyz;
  highp float tmpvar_7;
  tmpvar_7 = dot (LightCoord_6, LightCoord_6);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2(tmpvar_7));
  lowp float tmpvar_9;
  highp vec4 shadowCoord_10;
  shadowCoord_10 = xlv_TEXCOORD3;
  highp vec4 shadowVals_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (shadowCoord_10.xyz / shadowCoord_10.w);
  shadowVals_11.x = texture2D (_ShadowMapTexture, (tmpvar_12.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_11.y = texture2D (_ShadowMapTexture, (tmpvar_12.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_11.z = texture2D (_ShadowMapTexture, (tmpvar_12.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_11.w = texture2D (_ShadowMapTexture, (tmpvar_12.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_13;
  tmpvar_13 = lessThan (shadowVals_11, tmpvar_12.zzzz);
  mediump vec4 tmpvar_14;
  tmpvar_14 = _LightShadowData.xxxx;
  mediump float tmpvar_15;
  if (tmpvar_13.x) {
    tmpvar_15 = tmpvar_14.x;
  } else {
    tmpvar_15 = 1.0;
  };
  mediump float tmpvar_16;
  if (tmpvar_13.y) {
    tmpvar_16 = tmpvar_14.y;
  } else {
    tmpvar_16 = 1.0;
  };
  mediump float tmpvar_17;
  if (tmpvar_13.z) {
    tmpvar_17 = tmpvar_14.z;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  if (tmpvar_13.w) {
    tmpvar_18 = tmpvar_14.w;
  } else {
    tmpvar_18 = 1.0;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_15;
  tmpvar_19.y = tmpvar_16;
  tmpvar_19.z = tmpvar_17;
  tmpvar_19.w = tmpvar_18;
  mediump float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_9 = tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_3;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD4;
  mediump float atten_23;
  atten_23 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * tmpvar_4.w) * tmpvar_8.w) * tmpvar_9);
  mediump vec4 c_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = normalize(lightDir_21);
  lightDir_21 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_22);
  normal_22 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (tmpvar_26, tmpvar_25);
  c_24.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_27) * (atten_23 * 4.0));
  c_24.w = (tmpvar_27 * (atten_23 * 4.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_29;
  lightDir_29 = tmpvar_28;
  mediump vec3 normal_30;
  normal_30 = xlv_TEXCOORD4;
  mediump float tmpvar_31;
  tmpvar_31 = dot (normal_30, lightDir_29);
  color_2 = (c_24 * mix (1.0, clamp (
    floor((1.01 + tmpvar_31))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_31))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "opengl " {
// Stats: 37 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * tmpvar_3);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightShadowData;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  vec4 shadows_2;
  vec3 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
  shadows_2.x = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[0].xyz)).x;
  shadows_2.y = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[1].xyz)).x;
  shadows_2.z = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[2].xyz)).x;
  shadows_2.w = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[3].xyz)).x;
  shadows_2 = (_LightShadowData.xxxx + (shadows_2 * (1.0 - _LightShadowData.xxxx)));
  float atten_4;
  atten_4 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz))).w) * dot (shadows_2, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_5;
  float tmpvar_6;
  tmpvar_6 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_5.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_6) * (atten_4 * 4.0));
  c_5.w = (tmpvar_6 * (atten_4 * 4.0));
  float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_5 * mix (1.0, clamp (
    floor((1.01 + tmpvar_7))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_7))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 44 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 12 [_LightMatrix0]
Matrix 8 [_Object2World]
Matrix 4 [glstate_matrix_mvp]
Matrix 0 [unity_World2Shadow0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
"vs_3_0
def c18, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, r0, -c16
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c8, v2
dp3 r1.y, c9, v2
dp3 r1.z, c10, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c17
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c18.y
mul_sat r1.x, r1.x, c18.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c18.z
mad o7.x, r1.x, r1.y, c18.w
dp4 r0.w, c11, v0
dp4 o3.x, c12, r0
dp4 o3.y, c13, r0
dp4 o3.z, c14, r0
dp4 o3.w, c15, r0
dp4 o4.x, c0, r0
dp4 o4.y, c1, r0
dp4 o4.z, c2, r0
dp4 o4.w, c3, r0
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 40 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 544
Matrix 160 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
root12:aaafaaaa
eefieceddlddjjofihndkgdlfaabjankhainfgfgabaaaaaalaaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaaiahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleagaaaaeaaaabaa
knabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
amaaaaaafjaaaaaeegiocaaaaeaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
iccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaelaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaahaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaa
anaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaafaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
// Stats: 37 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_9, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_16;
  tmpvar_7 = (_LightMatrix0 * tmpvar_11);
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  mediump vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  highp vec4 shadowCoord_9;
  shadowCoord_9 = xlv_TEXCOORD3;
  mediump vec4 shadows_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (shadowCoord_9.xyz / shadowCoord_9.w);
  highp vec3 coord_12;
  coord_12 = (tmpvar_11 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, coord_12);
  shadows_10.x = tmpvar_13;
  highp vec3 coord_14;
  coord_14 = (tmpvar_11 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_15;
  tmpvar_15 = shadow2DEXT (_ShadowMapTexture, coord_14);
  shadows_10.y = tmpvar_15;
  highp vec3 coord_16;
  coord_16 = (tmpvar_11 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_17;
  tmpvar_17 = shadow2DEXT (_ShadowMapTexture, coord_16);
  shadows_10.z = tmpvar_17;
  highp vec3 coord_18;
  coord_18 = (tmpvar_11 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_19;
  tmpvar_19 = shadow2DEXT (_ShadowMapTexture, coord_18);
  shadows_10.w = tmpvar_19;
  shadows_10 = (_LightShadowData.xxxx + (shadows_10 * (1.0 - _LightShadowData.xxxx)));
  mediump float tmpvar_20;
  tmpvar_20 = dot (shadows_10, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_3;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD4;
  mediump float atten_23;
  atten_23 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = normalize(lightDir_21);
  lightDir_21 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_22);
  normal_22 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (tmpvar_26, tmpvar_25);
  c_24.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_27) * (atten_23 * 4.0));
  c_24.w = (tmpvar_27 * (atten_23 * 4.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_29;
  lightDir_29 = tmpvar_28;
  mediump vec3 normal_30;
  normal_30 = xlv_TEXCOORD4;
  mediump float tmpvar_31;
  tmpvar_31 = dot (normal_30, lightDir_29);
  color_2 = (c_24 * mix (1.0, clamp (
    floor((1.01 + tmpvar_31))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_31))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _ShadowOffsets[4];
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump vec4 t16_2;
highp vec3 t3;
mediump float t16_6;
highp float t12;
highp float t13;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t12 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t12);
    t12 = inversesqrt(t12);
    vs_TEXCOORD7.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    t0.x = dot(t16_0, t1);
    t16_2.x = _LightMatrix0[0].y;
    t16_2.y = _LightMatrix0[1].y;
    t16_2.z = _LightMatrix0[2].y;
    t16_2.w = _LightMatrix0[3].y;
    t0.y = dot(t16_2, t1);
    t16_2.x = _LightMatrix0[0].z;
    t16_2.y = _LightMatrix0[1].z;
    t16_2.z = _LightMatrix0[2].z;
    t16_2.w = _LightMatrix0[3].z;
    t0.z = dot(t16_2, t1);
    t16_2.x = _LightMatrix0[0].w;
    t16_2.y = _LightMatrix0[1].w;
    t16_2.z = _LightMatrix0[2].w;
    t16_2.w = _LightMatrix0[3].w;
    t0.w = dot(t16_2, t1);
    vs_TEXCOORD2 = t0;
    t0 = t1.yyyy * unity_World2Shadow[0][1];
    t0 = unity_World2Shadow[0][0] * t1.xxxx + t0;
    t0 = unity_World2Shadow[0][2] * t1.zzzz + t0;
    t0 = unity_World2Shadow[0][3] * t1.wwww + t0;
    vs_TEXCOORD3 = t0;
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    vs_TEXCOORD4.xyz = vec3(t13) * t1.xyz;
    t1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * _WorldSpaceLightPos0.xyz;
    t3.xy = in_TEXCOORD0.xy;
    t3.z = in_TEXCOORD1.x;
    t1.x = dot((-t3.xyz), t1.xyz);
    vs_TEXCOORD5.xyz = (-t3.xyz);
    t16_2.x = t1.x + 1.00999999;
    t16_6 = t1.x * -10.0;
    t16_6 = clamp(t16_6, 0.0, 1.0);
    t16_2.x = floor(t16_2.x);
    t16_2.x = clamp(t16_2.x, 0.0, 1.0);
    t16_2.x = t16_2.x + -1.0;
    t16_2.x = t16_6 * t16_2.x + 1.0;
    vs_TEXCOORD6 = t16_2.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _ShadowOffsets[4];
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
highp vec3 t1;
mediump vec3 t16_1;
highp vec4 t2;
highp vec3 t3;
lowp float t10_4;
mediump vec3 t16_5;
mediump vec3 t16_6;
lowp float t10_7;
mediump float t16_12;
bool tb13;
highp float t19;
void main()
{
    t16_0.x = (-_LightShadowData.x) + 1.0;
    t16_1.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    t2.xyz = t16_1.xyz + _ShadowOffsets[0].xyz;
    vec3 txVec40 = vec3(t2.xy,t2.z);
    t2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec40, 0.0);
    t3.xyz = t16_1.xyz + _ShadowOffsets[1].xyz;
    vec3 txVec41 = vec3(t3.xy,t3.z);
    t2.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec41, 0.0);
    t3.xyz = t16_1.xyz + _ShadowOffsets[2].xyz;
    t1.xyz = t16_1.xyz + _ShadowOffsets[3].xyz;
    vec3 txVec42 = vec3(t1.xy,t1.z);
    t2.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec42, 0.0);
    vec3 txVec43 = vec3(t3.xy,t3.z);
    t2.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec43, 0.0);
    t16_0 = t2 * t16_0.xxxx + _LightShadowData.xxxx;
    t16_1.x = dot(t16_0, vec4(0.25, 0.25, 0.25, 0.25));
    t16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t16_0.xy = t16_0.xy + vec2(0.5, 0.5);
    t10_7 = texture(_LightTexture0, t16_0.xy).w;
    tb13 = 0.0<vs_TEXCOORD2.z;
    t10_4 = (tb13) ? 1.0 : 0.0;
    t10_4 = t10_7 * t10_4;
    t16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_7 = texture(_LightTextureB0, t16_0.xx).w;
    t10_4 = t10_7 * t10_4;
    t10_4 = t16_1.x * t10_4;
    t16_0.x = t10_4 * 4.0;
    t16_6.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_6.x = inversesqrt(t16_6.x);
    t16_6.xyz = t16_6.xxx * _WorldSpaceLightPos0.xyz;
    t16_5.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_5.x = inversesqrt(t16_5.x);
    t16_5.xyz = t16_5.xxx * vs_TEXCOORD4.xyz;
    t16_6.x = dot(t16_5.xyz, t16_6.xyz);
    t16_5.xyz = _LightColor0.xyz * _Color.xyz;
    t16_5.xyz = t16_6.xxx * t16_5.xyz;
    t16_6.x = t16_0.x * t16_6.x;
    t16_1.xyz = t16_0.xxx * t16_5.xyz;
    t19 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t19 = inversesqrt(t19);
    t2.xyz = vec3(t19) * _WorldSpaceLightPos0.xyz;
    t16_0.x = dot(vs_TEXCOORD4.xyz, t2.xyz);
    t16_12 = t16_0.x + 1.00999999;
    t16_0.x = t16_0.x * -10.0;
    t16_0.x = clamp(t16_0.x, 0.0, 1.0);
    t16_12 = floor(t16_12);
    t16_12 = clamp(t16_12, 0.0, 1.0);
    t16_12 = t16_12 + -1.0;
    t16_0.x = t16_0.x * t16_12 + 1.0;
    t16_5.xyz = t16_0.xxx * t16_1.xyz;
    t16_0.w = t16_0.x * t16_6.x;
    t16_0.xyz = t16_0.www * t16_5.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 448
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [_Object2World]
MatrixHalf 416 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  half4 tmpvar_5;
  half4 tmpvar_6;
  float3 tmpvar_7;
  float tmpvar_8;
  float4 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_10, tmpvar_10));
  float4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _mtl_i._glesNormal;
  float4 tmpvar_12;
  tmpvar_12.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_12.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_12.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_13);
  half tmpvar_14;
  tmpvar_14 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_8 = float(tmpvar_14);
  tmpvar_5 = half4(((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_9)));
  tmpvar_6 = half4((_mtl_u.unity_World2Shadow[0] * tmpvar_9));
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_11).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _ShadowOffsets[4];
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec4 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t6 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t6);
    t6 = inversesqrt(t6);
    vs_TEXCOORD7.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * _LightMatrix0[1];
    t1 = _LightMatrix0[0] * t0.xxxx + t1;
    t1 = _LightMatrix0[2] * t0.zzzz + t1;
    vs_TEXCOORD2 = _LightMatrix0[3] * t0.wwww + t1;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    vs_TEXCOORD3 = unity_World2Shadow[0][3] * t0.wwww + t1;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _ShadowOffsets[4];
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _LightTextureB0;
uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform  sampler2D _ShadowMapTexture;
in  vec4 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
lowp vec4 t10_1;
vec4 t2;
vec3 t3;
bool tb3;
float t6;
void main()
{
    t0.x = (-_LightShadowData.x) + 1.0;
    t3.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    t1.xyz = t3.xyz + _ShadowOffsets[0].xyz;
    vec3 txVec38 = vec3(t1.xy,t1.z);
    t1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec38, 0.0);
    t2.xyz = t3.xyz + _ShadowOffsets[1].xyz;
    vec3 txVec39 = vec3(t2.xy,t2.z);
    t1.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec39, 0.0);
    t2.xyz = t3.xyz + _ShadowOffsets[2].xyz;
    t3.xyz = t3.xyz + _ShadowOffsets[3].xyz;
    vec3 txVec40 = vec3(t3.xy,t3.z);
    t1.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec40, 0.0);
    vec3 txVec41 = vec3(t2.xy,t2.z);
    t1.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec41, 0.0);
    t0 = t1 * t0.xxxx + _LightShadowData.xxxx;
    t0.x = dot(t0, vec4(0.25, 0.25, 0.25, 0.25));
    t3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t3.xy = t3.xy + vec2(0.5, 0.5);
    t10_1 = texture(_LightTexture0, t3.xy);
    tb3 = 0.0<vs_TEXCOORD2.z;
    t3.x = tb3 ? 1.0 : float(0.0);
    t3.x = t10_1.w * t3.x;
    t6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, vec2(t6));
    t3.x = t3.x * t10_1.w;
    t0.x = t0.x * t3.x;
    t0.x = t0.x * 4.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t2.w = t0.x * t3.x;
    t2.xyz = t0.xxx * t1.xyz;
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 36 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xyz;
  xlv_TEXCOORD3 = (tmpvar_3.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)));
  vec4 shadowVals_3;
  shadowVals_3.x = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_3.y = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_3.z = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_3.w = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_4;
  tmpvar_4 = lessThan (shadowVals_3, vec4(((
    sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_5;
  tmpvar_5 = _LightShadowData.xxxx;
  float tmpvar_6;
  if (tmpvar_4.x) {
    tmpvar_6 = tmpvar_5.x;
  } else {
    tmpvar_6 = 1.0;
  };
  float tmpvar_7;
  if (tmpvar_4.y) {
    tmpvar_7 = tmpvar_5.y;
  } else {
    tmpvar_7 = 1.0;
  };
  float tmpvar_8;
  if (tmpvar_4.z) {
    tmpvar_8 = tmpvar_5.z;
  } else {
    tmpvar_8 = 1.0;
  };
  float tmpvar_9;
  if (tmpvar_4.w) {
    tmpvar_9 = tmpvar_5.w;
  } else {
    tmpvar_9 = 1.0;
  };
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_6;
  tmpvar_10.y = tmpvar_7;
  tmpvar_10.z = tmpvar_8;
  tmpvar_10.w = tmpvar_9;
  float atten_11;
  atten_11 = (tmpvar_2.w * dot (tmpvar_10, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_12;
  float tmpvar_13;
  tmpvar_13 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_12.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_11 * 4.0));
  c_12.w = (tmpvar_13 * (atten_11 * 4.0));
  float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_LightPositionRange]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
"vs_3_0
def c14, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c11
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c12
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c14.y
mul_sat r1.x, r1.x, c14.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c14.z
mad o7.x, r1.x, r1.y, c14.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
add o4.xyz, r0, -c13
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecednjiafaehceelhfdjldhgjnbjolnaneimabaaaaaacmaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaahaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 40 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_9).xyz;
  xlv_TEXCOORD3 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  highp vec4 shadowVals_6;
  highp float mydist_7;
  mydist_7 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_6.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_6.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_6.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_6.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (shadowVals_6, vec4(mydist_7));
  mediump vec4 tmpvar_9;
  tmpvar_9 = _LightShadowData.xxxx;
  mediump float tmpvar_10;
  if (tmpvar_8.x) {
    tmpvar_10 = tmpvar_9.x;
  } else {
    tmpvar_10 = 1.0;
  };
  mediump float tmpvar_11;
  if (tmpvar_8.y) {
    tmpvar_11 = tmpvar_9.y;
  } else {
    tmpvar_11 = 1.0;
  };
  mediump float tmpvar_12;
  if (tmpvar_8.z) {
    tmpvar_12 = tmpvar_9.z;
  } else {
    tmpvar_12 = 1.0;
  };
  mediump float tmpvar_13;
  if (tmpvar_8.w) {
    tmpvar_13 = tmpvar_9.w;
  } else {
    tmpvar_13 = 1.0;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_10;
  tmpvar_14.y = tmpvar_11;
  tmpvar_14.z = tmpvar_12;
  tmpvar_14.w = tmpvar_13;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_3;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD4;
  mediump float atten_17;
  atten_17 = (tmpvar_5.w * dot (tmpvar_14, vec4(0.25, 0.25, 0.25, 0.25)));
  mediump vec4 c_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(lightDir_15);
  lightDir_15 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_16);
  normal_16 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = dot (tmpvar_20, tmpvar_19);
  c_18.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_21) * (atten_17 * 4.0));
  c_18.w = (tmpvar_21 * (atten_17 * 4.0));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_23;
  lightDir_23 = tmpvar_22;
  mediump vec3 normal_24;
  normal_24 = xlv_TEXCOORD4;
  mediump float tmpvar_25;
  tmpvar_25 = dot (normal_24, lightDir_23);
  color_2 = (c_18 * mix (1.0, clamp (
    floor((1.01 + tmpvar_25))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_25))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump float t16_2;
mediump float t16_5;
highp float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_2 = t0.x + 1.00999999;
    t16_5 = t0.x * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2 = floor(t16_2);
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_2 = t16_2 + -1.0;
    t16_2 = t16_5 * t16_2 + 1.0;
    vs_TEXCOORD6 = t16_2;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].z;
    t16_0.y = _LightMatrix0[1].z;
    t16_0.z = _LightMatrix0[2].z;
    t16_0.w = _LightMatrix0[3].z;
    vs_TEXCOORD2.z = dot(t16_0, t1);
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    vs_TEXCOORD4.xyz = vec3(t10) * t1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
uniform highp samplerCube _ShadowMapTexture;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec4 t0;
mediump vec4 t16_0;
lowp float t10_0;
bvec4 tb0;
highp vec4 t1;
highp vec4 t2;
mediump float t16_3;
mediump vec3 t16_4;
highp vec3 t5;
mediump vec3 t16_8;
mediump float t16_13;
highp float t15;
void main()
{
    t0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t0.x = sqrt(t0.x);
    t0.x = t0.x * _LightPositionRange.w;
    t0.x = t0.x * 0.970000029;
    t5.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
    t1 = texture(_ShadowMapTexture, t5.xyz);
    t1.x = dot(t1, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    t5.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
    t2 = texture(_ShadowMapTexture, t5.xyz);
    t1.y = dot(t2, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    t5.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
    t2 = texture(_ShadowMapTexture, t5.xyz);
    t1.z = dot(t2, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    t5.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
    t2 = texture(_ShadowMapTexture, t5.xyz);
    t1.w = dot(t2, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    tb0 = lessThan(t1, t0.xxxx);
    t0.x = (tb0.x) ? _LightShadowData.x : float(1.0);
    t0.y = (tb0.y) ? _LightShadowData.x : float(1.0);
    t0.z = (tb0.z) ? _LightShadowData.x : float(1.0);
    t0.w = (tb0.w) ? _LightShadowData.x : float(1.0);
    t16_3 = dot(t0, vec4(0.25, 0.25, 0.25, 0.25));
    t0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_0 = texture(_LightTexture0, t0.xx).w;
    t16_0.x = t16_3 * t10_0;
    t16_3 = t16_0.x * 4.0;
    t16_8.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_8.x = inversesqrt(t16_8.x);
    t16_8.xyz = t16_8.xxx * _WorldSpaceLightPos0.xyz;
    t16_4.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_4.x = inversesqrt(t16_4.x);
    t16_4.xyz = t16_4.xxx * vs_TEXCOORD4.xyz;
    t16_8.x = dot(t16_4.xyz, t16_8.xyz);
    t16_4.xyz = _LightColor0.xyz * _Color.xyz;
    t16_4.xyz = t16_8.xxx * t16_4.xyz;
    t16_8.x = t16_3 * t16_8.x;
    t16_0.xyz = vec3(t16_3) * t16_4.xyz;
    t15 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t15 = inversesqrt(t15);
    t1.xyz = vec3(t15) * _WorldSpaceLightPos0.xyz;
    t16_3 = dot(vs_TEXCOORD4.xyz, t1.xyz);
    t16_13 = t16_3 + 1.00999999;
    t16_3 = t16_3 * -10.0;
    t16_3 = clamp(t16_3, 0.0, 1.0);
    t16_13 = floor(t16_13);
    t16_13 = clamp(t16_13, 0.0, 1.0);
    t16_13 = t16_13 + -1.0;
    t16_3 = t16_3 * t16_13 + 1.0;
    t16_4.xyz = t16_0.xyz * vec3(t16_3);
    t16_0.w = t16_3 * t16_8.x;
    t16_0.xyz = t16_0.www * t16_4.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 208
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
MatrixHalf 176 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
Vector 32 [_LightPositionRange]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  float3 tmpvar_5;
  float tmpvar_6;
  float4 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _mtl_i._glesNormal;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_5 = -(tmpvar_10.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_11);
  half tmpvar_12;
  tmpvar_12 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_12);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_7)).xyz;
  _mtl_o.xlv_TEXCOORD3 = (tmpvar_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xyz = t0.yyy * _LightMatrix0[1].xyz;
    t1.xyz = _LightMatrix0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = _LightMatrix0[2].xyz * t0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _LightMatrix0[3].xyz * t0.www + t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTexture0;
uniform  samplerCube _ShadowMapTexture;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
bvec4 tb0;
vec4 t1;
lowp vec4 t10_1;
vec4 t2;
lowp vec4 t10_2;
vec3 t3;
void main()
{
    t0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t0.x = sqrt(t0.x);
    t0.x = t0.x * _LightPositionRange.w;
    t0.x = t0.x * 0.970000029;
    t3.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
    t1 = texture(_ShadowMapTexture, t3.xyz);
    t3.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
    t10_2 = texture(_ShadowMapTexture, t3.xyz);
    t1.y = t10_2.x;
    t3.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
    t10_2 = texture(_ShadowMapTexture, t3.xyz);
    t1.z = t10_2.x;
    t3.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
    t10_2 = texture(_ShadowMapTexture, t3.xyz);
    t1.w = t10_2.x;
    tb0 = lessThan(t1, t0.xxxx);
    t0.x = (tb0.x) ? _LightShadowData.x : float(1.0);
    t0.y = (tb0.y) ? _LightShadowData.x : float(1.0);
    t0.z = (tb0.z) ? _LightShadowData.x : float(1.0);
    t0.w = (tb0.w) ? _LightShadowData.x : float(1.0);
    t0.x = dot(t0, vec4(0.25, 0.25, 0.25, 0.25));
    t3.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTexture0, t3.xx);
    t0.x = t0.x * t10_1.w;
    t0.x = t0.x * 4.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t2.w = t0.x * t3.x;
    t2.xyz = t0.xxx * t1.xyz;
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 37 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  tmpvar_2 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_2, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_3).xyz;
  xlv_TEXCOORD3 = (tmpvar_3.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_2;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)));
  vec4 tmpvar_3;
  tmpvar_3 = textureCube (_LightTexture0, xlv_TEXCOORD2);
  vec4 shadowVals_4;
  shadowVals_4.x = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_4.y = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_4.z = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_4.w = textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_5;
  tmpvar_5 = lessThan (shadowVals_4, vec4(((
    sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_6;
  tmpvar_6 = _LightShadowData.xxxx;
  float tmpvar_7;
  if (tmpvar_5.x) {
    tmpvar_7 = tmpvar_6.x;
  } else {
    tmpvar_7 = 1.0;
  };
  float tmpvar_8;
  if (tmpvar_5.y) {
    tmpvar_8 = tmpvar_6.y;
  } else {
    tmpvar_8 = 1.0;
  };
  float tmpvar_9;
  if (tmpvar_5.z) {
    tmpvar_9 = tmpvar_6.z;
  } else {
    tmpvar_9 = 1.0;
  };
  float tmpvar_10;
  if (tmpvar_5.w) {
    tmpvar_10 = tmpvar_6.w;
  } else {
    tmpvar_10 = 1.0;
  };
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_7;
  tmpvar_11.y = tmpvar_8;
  tmpvar_11.z = tmpvar_9;
  tmpvar_11.w = tmpvar_10;
  float atten_12;
  atten_12 = ((tmpvar_2.w * tmpvar_3.w) * dot (tmpvar_11, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_13;
  float tmpvar_14;
  tmpvar_14 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_13.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_12 * 4.0));
  c_13.w = (tmpvar_14 * (atten_12 * 4.0));
  float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  color_1 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_15))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_15))
  , 0.0, 1.0)));
  color_1.xyz = (color_1.xyz * color_1.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_LightPositionRange]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
"vs_3_0
def c14, -10, 1.00999999, -1, 1
dcl_position v0
dcl_color v1
dcl_normal v2
dcl_texcoord v3
dcl_texcoord1 v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.x
dcl_texcoord7 o8.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c11
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp o2.w, r1.w
mul o8.xyz, r1.w, r1
dp3 r1.x, c4, v2
dp3 r1.y, c5, v2
dp3 r1.z, c6, v2
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul o5.xyz, r1.w, r1
nrm r1.xyz, c12
mov r2.xy, v3
mov r2.z, v4.x
dp3 r1.x, -r2, r1
mov o6.xyz, -r2
add r1.y, r1.x, c14.y
mul_sat r1.x, r1.x, c14.x
frc r1.z, r1.y
add_sat r1.y, -r1.z, r1.y
add r1.y, r1.y, c14.z
mad o7.x, r1.x, r1.y, c14.w
dp4 r0.w, c7, v0
dp4 o3.x, c8, r0
dp4 o3.y, c9, r0
dp4 o3.z, c10, r0
add o4.xyz, r0, -c13
mov o1, v1
mov o2.xyz, v2

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 480
Matrix 96 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
root12:aaaeaaaa
eefiecednjiafaehceelhfdjldhgjnbjolnaneimabaaaaaacmaiaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaahaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajbcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 41 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  tmpvar_7 = -(tmpvar_12.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * tmpvar_9).xyz;
  xlv_TEXCOORD3 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD2);
  highp vec4 shadowVals_7;
  highp float mydist_8;
  mydist_8 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_7.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_7.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_7.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_7.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_7, vec4(mydist_8));
  mediump vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  mediump float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  mediump float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  mediump float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  mediump float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  mediump vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_3;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD4;
  mediump float atten_18;
  atten_18 = ((tmpvar_5.w * tmpvar_6.w) * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25)));
  mediump vec4 c_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(lightDir_16);
  lightDir_16 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(normal_17);
  normal_17 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, tmpvar_20);
  c_19.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_22) * (atten_18 * 4.0));
  c_19.w = (tmpvar_22 * (atten_18 * 4.0));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_24;
  lightDir_24 = tmpvar_23;
  mediump vec3 normal_25;
  normal_25 = xlv_TEXCOORD4;
  mediump float tmpvar_26;
  tmpvar_26 = dot (normal_25, lightDir_24);
  color_2 = (c_19 * mix (1.0, clamp (
    floor((1.01 + tmpvar_26))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_26))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
mediump float t16_2;
mediump float t16_5;
highp float t10;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_2 = t0.x + 1.00999999;
    t16_5 = t0.x * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2 = floor(t16_2);
    t16_2 = clamp(t16_2, 0.0, 1.0);
    t16_2 = t16_2 + -1.0;
    t16_2 = t16_5 * t16_2 + 1.0;
    vs_TEXCOORD6 = t16_2;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    vs_TEXCOORD2.y = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].z;
    t16_0.y = _LightMatrix0[1].z;
    t16_0.z = _LightMatrix0[2].z;
    t16_0.w = _LightMatrix0[3].z;
    vs_TEXCOORD2.z = dot(t16_0, t1);
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    vs_TEXCOORD4.xyz = vec3(t10) * t1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
uniform highp samplerCube _ShadowMapTexture;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec4 t0;
mediump vec4 t16_0;
lowp float t10_0;
bvec4 tb0;
highp vec4 t1;
highp vec4 t2;
mediump float t16_3;
mediump vec3 t16_4;
highp vec3 t5;
lowp float t10_5;
mediump vec3 t16_8;
mediump float t16_13;
highp float t15;
void main()
{
    t0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t0.x = sqrt(t0.x);
    t0.x = t0.x * _LightPositionRange.w;
    t0.x = t0.x * 0.970000029;
    t5.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
    t1 = texture(_ShadowMapTexture, t5.xyz);
    t1.x = dot(t1, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    t5.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
    t2 = texture(_ShadowMapTexture, t5.xyz);
    t1.y = dot(t2, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    t5.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
    t2 = texture(_ShadowMapTexture, t5.xyz);
    t1.z = dot(t2, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    t5.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
    t2 = texture(_ShadowMapTexture, t5.xyz);
    t1.w = dot(t2, vec4(1.0, 0.00392156886, 1.53787005e-005, 6.03086292e-008));
    tb0 = lessThan(t1, t0.xxxx);
    t0.x = (tb0.x) ? _LightShadowData.x : float(1.0);
    t0.y = (tb0.y) ? _LightShadowData.x : float(1.0);
    t0.z = (tb0.z) ? _LightShadowData.x : float(1.0);
    t0.w = (tb0.w) ? _LightShadowData.x : float(1.0);
    t16_3 = dot(t0, vec4(0.25, 0.25, 0.25, 0.25));
    t0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_0 = texture(_LightTextureB0, t0.xx).w;
    t10_5 = texture(_LightTexture0, vs_TEXCOORD2.xyz).w;
    t16_0.x = t10_5 * t10_0;
    t16_0.x = t16_3 * t16_0.x;
    t16_3 = t16_0.x * 4.0;
    t16_8.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_8.x = inversesqrt(t16_8.x);
    t16_8.xyz = t16_8.xxx * _WorldSpaceLightPos0.xyz;
    t16_4.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_4.x = inversesqrt(t16_4.x);
    t16_4.xyz = t16_4.xxx * vs_TEXCOORD4.xyz;
    t16_8.x = dot(t16_4.xyz, t16_8.xyz);
    t16_4.xyz = _LightColor0.xyz * _Color.xyz;
    t16_4.xyz = t16_8.xxx * t16_4.xyz;
    t16_8.x = t16_3 * t16_8.x;
    t16_0.xyz = vec3(t16_3) * t16_4.xyz;
    t15 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t15 = inversesqrt(t15);
    t1.xyz = vec3(t15) * _WorldSpaceLightPos0.xyz;
    t16_3 = dot(vs_TEXCOORD4.xyz, t1.xyz);
    t16_13 = t16_3 + 1.00999999;
    t16_3 = t16_3 * -10.0;
    t16_3 = clamp(t16_3, 0.0, 1.0);
    t16_13 = floor(t16_13);
    t16_13 = clamp(t16_13, 0.0, 1.0);
    t16_13 = t16_13 + -1.0;
    t16_3 = t16_3 * t16_13 + 1.0;
    t16_4.xyz = t16_0.xyz * vec3(t16_3);
    t16_0.w = t16_3 * t16_8.x;
    t16_0.xyz = t16_0.www * t16_4.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 208
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
MatrixHalf 176 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_WorldSpaceLightPos0]
Vector 32 [_LightPositionRange]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float4 tmpvar_3;
  float4 tmpvar_4;
  float3 tmpvar_5;
  float tmpvar_6;
  float4 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_4.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _mtl_i._glesNormal;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_5 = -(tmpvar_10.xyz);
  tmpvar_3 = float4(tmpvar_1);
  tmpvar_4.xyz = _mtl_i._glesNormal;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_2 = half(tmpvar_11);
  half tmpvar_12;
  tmpvar_12 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_12);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD2 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_7)).xyz;
  _mtl_o.xlv_TEXCOORD3 = (tmpvar_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in  vec4 in_POSITION0;
in  vec4 in_COLOR0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_TEXCOORD1;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out float vs_TEXCOORD6;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
out vec3 vs_TEXCOORD7;
vec4 t0;
vec3 t1;
float t2;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t1.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    vs_TEXCOORD3.xyz = t0.xyz + (-_LightPositionRange.xyz);
    t0.x = dot(t1.xyz, t1.xyz);
    vs_TEXCOORD1.w = sqrt(t0.x);
    t0.x = inversesqrt(t0.x);
    vs_TEXCOORD7.xyz = t0.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1.xyz = t0.yyy * _LightMatrix0[1].xyz;
    t1.xyz = _LightMatrix0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = _LightMatrix0[2].xyz * t0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _LightMatrix0[3].xyz * t0.www + t0.xyz;
    t0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    t0.x = dot((-t1.xyz), t0.xyz);
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t2 = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t2 = floor(t2);
    t2 = clamp(t2, 0.0, 1.0);
    t2 = t2 + -1.0;
    vs_TEXCOORD6 = t0.x * t2 + 1.0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD4.xyz = vec3(t6) * t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	mat4 _LightMatrix0;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	vec4 _Color;
uniform 	float _SpecularPower;
uniform 	vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform  sampler2D _LightTextureB0;
uniform  samplerCube _LightTexture0;
uniform  samplerCube _ShadowMapTexture;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
out vec4 SV_Target0;
vec4 t0;
bvec4 tb0;
vec4 t1;
lowp vec4 t10_1;
vec4 t2;
lowp vec4 t10_2;
vec3 t3;
mediump float t16_3;
void main()
{
    t0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t0.x = sqrt(t0.x);
    t0.x = t0.x * _LightPositionRange.w;
    t0.x = t0.x * 0.970000029;
    t3.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
    t1 = texture(_ShadowMapTexture, t3.xyz);
    t3.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
    t10_2 = texture(_ShadowMapTexture, t3.xyz);
    t1.y = t10_2.x;
    t3.xyz = vs_TEXCOORD3.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
    t10_2 = texture(_ShadowMapTexture, t3.xyz);
    t1.z = t10_2.x;
    t3.xyz = vs_TEXCOORD3.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
    t10_2 = texture(_ShadowMapTexture, t3.xyz);
    t1.w = t10_2.x;
    tb0 = lessThan(t1, t0.xxxx);
    t0.x = (tb0.x) ? _LightShadowData.x : float(1.0);
    t0.y = (tb0.y) ? _LightShadowData.x : float(1.0);
    t0.z = (tb0.z) ? _LightShadowData.x : float(1.0);
    t0.w = (tb0.w) ? _LightShadowData.x : float(1.0);
    t0.x = dot(t0, vec4(0.25, 0.25, 0.25, 0.25));
    t3.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t10_1 = texture(_LightTextureB0, t3.xx);
    t10_2 = texture(_LightTexture0, vs_TEXCOORD2.xyz);
    t16_3 = t10_1.w * t10_2.w;
    t0.x = t0.x * t16_3;
    t0.x = t0.x * 4.0;
    t3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t3.x = inversesqrt(t3.x);
    t3.xyz = t3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t1.x = inversesqrt(t1.x);
    t1.xyz = t1.xxx * vs_TEXCOORD4.xyz;
    t3.x = dot(t1.xyz, t3.xyz);
    t1.xyz = _LightColor0.xyz * _Color.xyz;
    t1.xyz = t3.xxx * t1.xyz;
    t2.w = t0.x * t3.x;
    t2.xyz = t0.xxx * t1.xyz;
    t0.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * _WorldSpaceLightPos0.xyz;
    t0.x = dot(vs_TEXCOORD4.xyz, t0.xyz);
    t3.x = t0.x + 1.00999999;
    t0.x = t0.x * -10.0;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t3.x = floor(t3.x);
    t3.x = clamp(t3.x, 0.0, 1.0);
    t3.x = t3.x + -1.0;
    t0.x = t0.x * t3.x + 1.0;
    t0 = t0.xxxx * t2;
    SV_Target0.xyz = t0.www * t0.xyz;
    SV_Target0.w = t0.w;
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 23 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp float tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_12, tmpvar_12));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14.xy = _glesMultiTexCoord0.xy;
  tmpvar_14.z = tmpvar_3.x;
  tmpvar_14.w = tmpvar_3.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_9, lightDirection_5);
  NdotL_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_10 = tmpvar_17;
  tmpvar_8 = (unity_World2Shadow[0] * tmpvar_11);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_13).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp float shadow_3;
  shadow_3 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz) * (1.0 - _LightShadowData.x)));
  mediump vec3 normal_4;
  normal_4 = xlv_TEXCOORD4;
  mediump float atten_5;
  atten_5 = shadow_3;
  mediump vec4 c_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(normal_4);
  normal_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  c_6.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_5 * 4.0));
  c_6.w = (tmpvar_8 * (atten_5 * 4.0));
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
  mediump float tmpvar_10;
  tmpvar_10 = dot (normal_9, normalize(_WorldSpaceLightPos0).xyz);
  color_2 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_10))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_10))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
highp vec4 t1;
mediump vec3 t16_2;
mediump float t16_5;
highp float t9;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t9 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t9);
    t9 = inversesqrt(t9);
    vs_TEXCOORD7.xyz = vec3(t9) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
    vs_TEXCOORD2 = t0;
    t0.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t0.xyz;
    t9 = dot(t0.xyz, t0.xyz);
    t9 = inversesqrt(t9);
    vs_TEXCOORD4.xyz = vec3(t9) * t0.xyz;
    t16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_2.x = inversesqrt(t16_2.x);
    t16_2.xyz = t16_2.xxx * _WorldSpaceLightPos0.xyz;
    t0.xy = in_TEXCOORD0.xy;
    t0.z = in_TEXCOORD1.x;
    t9 = dot((-t0.xyz), t16_2.xyz);
    vs_TEXCOORD5.xyz = (-t0.xyz);
    t16_2.x = t9 + 1.00999999;
    t16_5 = t9 * -10.0;
    t16_5 = clamp(t16_5, 0.0, 1.0);
    t16_2.x = floor(t16_2.x);
    t16_2.x = clamp(t16_2.x, 0.0, 1.0);
    t16_2.x = t16_2.x + -1.0;
    t16_2.x = t16_5 * t16_2.x + 1.0;
    vs_TEXCOORD6 = t16_2.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
mediump float t16_4;
mediump float t16_6;
mediump float t16_9;
void main()
{
    t16_0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_0.x = inversesqrt(t16_0.x);
    t16_0.xyz = t16_0.xxx * _WorldSpaceLightPos0.xyz;
    t16_9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_9 = inversesqrt(t16_9);
    t16_1.xyz = vec3(t16_9) * vs_TEXCOORD4.xyz;
    t16_0.x = dot(t16_1.xyz, t16_0.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_0.xxx * t16_3.xyz;
    vec3 txVec37 = vec3(vs_TEXCOORD2.xy,vs_TEXCOORD2.z);
    t16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec37, 0.0);
    t16_4 = (-_LightShadowData.x) + 1.0;
    t16_1.x = t16_1.x * t16_4 + _LightShadowData.x;
    t16_1.x = t16_1.x * 4.0;
    t16_2.xyz = t16_3.xyz * t16_1.xxx;
    t16_0.x = t16_0.x * t16_1.x;
    t16_3.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, t16_3.xyz);
    t16_6 = t16_3.x + 1.00999999;
    t16_3.x = t16_3.x * -10.0;
    t16_3.x = clamp(t16_3.x, 0.0, 1.0);
    t16_6 = floor(t16_6);
    t16_6 = clamp(t16_6, 0.0, 1.0);
    t16_6 = t16_6 + -1.0;
    t16_3.x = t16_3.x * t16_6 + 1.0;
    t16_1.xyz = t16_3.xxx * t16_2.xyz;
    t16_0.w = t16_3.x * t16_0.x;
    t16_0.xyz = t16_0.www * t16_1.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 176
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  half4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float3 lightDirection_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float4 tmpvar_6;
  half4 tmpvar_7;
  float3 tmpvar_8;
  float tmpvar_9;
  tmpvar_4 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_10;
  tmpvar_10 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - _mtl_u._WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_11, tmpvar_11));
  float4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _mtl_i._glesNormal;
  float4 tmpvar_13;
  tmpvar_13.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_13.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_13.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_8 = -(tmpvar_13.xyz);
  tmpvar_5 = float4(tmpvar_1);
  tmpvar_6.xyz = _mtl_i._glesNormal;
  half3 tmpvar_14;
  tmpvar_14 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_3 = float3(tmpvar_14);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_8, lightDirection_3);
  NdotL_2 = half(tmpvar_15);
  half tmpvar_16;
  tmpvar_16 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_9 = float(tmpvar_16);
  float4 o_17;
  float4 tmpvar_18;
  tmpvar_18 = (tmpvar_4 * 0.5);
  float2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _mtl_u._ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_4.zw;
  tmpvar_7 = half4(o_17);
  _mtl_o.gl_Position = tmpvar_4;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_12).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_10 - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 24 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  mediump vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_2;
  highp vec4 tmpvar_15;
  tmpvar_15.xy = _glesMultiTexCoord0.xy;
  tmpvar_15.z = tmpvar_3.x;
  tmpvar_15.w = tmpvar_3.y;
  tmpvar_10 = -(tmpvar_15.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_10, lightDirection_5);
  NdotL_4 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_11 = tmpvar_18;
  tmpvar_8 = (_LightMatrix0 * tmpvar_12).xy;
  tmpvar_9 = (unity_World2Shadow[0] * tmpvar_12);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_14).xyz);
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = normalize((tmpvar_12.xyz - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  lowp float shadow_4;
  shadow_4 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz) * (1.0 - _LightShadowData.x)));
  mediump vec3 normal_5;
  normal_5 = xlv_TEXCOORD4;
  mediump float atten_6;
  atten_6 = (tmpvar_3.w * shadow_4);
  mediump vec4 c_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((color_2.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_6 * 4.0));
  c_7.w = (tmpvar_9 * (atten_6 * 4.0));
  mediump vec3 normal_10;
  normal_10 = xlv_TEXCOORD4;
  mediump float tmpvar_11;
  tmpvar_11 = dot (normal_10, normalize(_WorldSpaceLightPos0).xyz);
  color_2 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_11))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_11))
  , 0.0, 1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
in highp vec4 in_POSITION0;
in lowp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
highp vec4 t0;
mediump vec4 t16_0;
highp vec4 t1;
highp vec2 t2;
mediump vec3 t16_3;
mediump float t16_7;
highp float t12;
highp float t13;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0 = in_COLOR0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    t0.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t12 = dot(t0.xyz, t0.xyz);
    vs_TEXCOORD1.w = sqrt(t12);
    t12 = inversesqrt(t12);
    vs_TEXCOORD7.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    t16_0.x = _LightMatrix0[0].x;
    t16_0.y = _LightMatrix0[1].x;
    t16_0.z = _LightMatrix0[2].x;
    t16_0.w = _LightMatrix0[3].x;
    t1 = in_POSITION0.yyyy * _Object2World[1];
    t1 = _Object2World[0] * in_POSITION0.xxxx + t1;
    t1 = _Object2World[2] * in_POSITION0.zzzz + t1;
    t1 = _Object2World[3] * in_POSITION0.wwww + t1;
    t2.x = dot(t16_0, t1);
    t16_0.x = _LightMatrix0[0].y;
    t16_0.y = _LightMatrix0[1].y;
    t16_0.z = _LightMatrix0[2].y;
    t16_0.w = _LightMatrix0[3].y;
    t2.y = dot(t16_0, t1);
    vs_TEXCOORD2.xy = t2.xy;
    t0 = t1.yyyy * unity_World2Shadow[0][1];
    t0 = unity_World2Shadow[0][0] * t1.xxxx + t0;
    t0 = unity_World2Shadow[0][2] * t1.zzzz + t0;
    t0 = unity_World2Shadow[0][3] * t1.wwww + t0;
    vs_TEXCOORD3 = t0;
    t1.xyz = in_NORMAL0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_NORMAL0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_NORMAL0.zzz + t1.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    vs_TEXCOORD4.xyz = vec3(t13) * t1.xyz;
    t1.xy = in_TEXCOORD0.xy;
    t1.z = in_TEXCOORD1.x;
    vs_TEXCOORD5.xyz = (-t1.xyz);
    t16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * _WorldSpaceLightPos0.xyz;
    t1.x = dot((-t1.xyz), t16_3.xyz);
    t16_3.x = t1.x * -10.0;
    t16_3.x = clamp(t16_3.x, 0.0, 1.0);
    t16_7 = t1.x + 1.00999999;
    t16_7 = floor(t16_7);
    t16_7 = clamp(t16_7, 0.0, 1.0);
    t16_7 = t16_7 + -1.0;
    t16_3.x = t16_3.x * t16_7 + 1.0;
    vs_TEXCOORD6 = t16_3.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump mat4 _LightMatrix0;
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mat4 _MainRotation;
uniform 	mat4 _DetailRotation;
uniform 	mat4 _ShadowBodies;
uniform 	float _SunRadius;
uniform 	vec3 _SunPos;
uniform 	lowp vec4 _Color;
uniform 	float _SpecularPower;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _DetailDist;
uniform 	float _PlanetOpacity;
uniform 	float _CityOverlayDetailScale;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
mediump vec3 t16_2;
lowp float t10_2;
mediump vec3 t16_3;
mediump float t16_4;
mediump float t16_6;
mediump float t16_9;
void main()
{
    t16_0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    t16_0.x = inversesqrt(t16_0.x);
    t16_0.xyz = t16_0.xxx * _WorldSpaceLightPos0.xyz;
    t16_9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    t16_9 = inversesqrt(t16_9);
    t16_1.xyz = vec3(t16_9) * vs_TEXCOORD4.xyz;
    t16_0.x = dot(t16_1.xyz, t16_0.xyz);
    t16_3.xyz = _LightColor0.xyz * _Color.xyz;
    t16_3.xyz = t16_0.xxx * t16_3.xyz;
    vec3 txVec47 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
    t16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec47, 0.0);
    t16_4 = (-_LightShadowData.x) + 1.0;
    t16_1.x = t16_1.x * t16_4 + _LightShadowData.x;
    t10_2 = texture(_LightTexture0, vs_TEXCOORD2.xy).w;
    t16_2.x = t16_1.x * t10_2;
    t16_1.x = t16_2.x * 4.0;
    t16_2.xyz = t16_3.xyz * t16_1.xxx;
    t16_0.x = t16_0.x * t16_1.x;
    t16_3.x = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    t16_3.x = inversesqrt(t16_3.x);
    t16_3.xyz = t16_3.xxx * _WorldSpaceLightPos0.xyz;
    t16_3.x = dot(vs_TEXCOORD4.xyz, t16_3.xyz);
    t16_6 = t16_3.x + 1.00999999;
    t16_3.x = t16_3.x * -10.0;
    t16_3.x = clamp(t16_3.x, 0.0, 1.0);
    t16_6 = floor(t16_6);
    t16_6 = clamp(t16_6, 0.0, 1.0);
    t16_6 = t16_6 + -1.0;
    t16_3.x = t16_3.x * t16_6 + 1.0;
    t16_1.xyz = t16_3.xxx * t16_2.xyz;
    t16_0.w = t16_3.x * t16_0.x;
    t16_0.xyz = t16_0.www * t16_1.xyz;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 24 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 208
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
MatrixHalf 176 [_LightMatrix0]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
  float4 _glesMultiTexCoord1 [[attribute(4)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float4 xlv_TEXCOORD1;
  half2 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  half4 _WorldSpaceLightPos0;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  half4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half NdotL_2;
  float3 lightDirection_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float4 tmpvar_6;
  half2 tmpvar_7;
  half4 tmpvar_8;
  float3 tmpvar_9;
  float tmpvar_10;
  tmpvar_4 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 tmpvar_11;
  tmpvar_11 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_12, tmpvar_12));
  float4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = _mtl_i._glesNormal;
  float4 tmpvar_14;
  tmpvar_14.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_14.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_14.w = _mtl_i._glesMultiTexCoord1.y;
  tmpvar_9 = -(tmpvar_14.xyz);
  tmpvar_5 = float4(tmpvar_1);
  tmpvar_6.xyz = _mtl_i._glesNormal;
  half3 tmpvar_15;
  tmpvar_15 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_3 = float3(tmpvar_15);
  float tmpvar_16;
  tmpvar_16 = dot (tmpvar_9, lightDirection_3);
  NdotL_2 = half(tmpvar_16);
  half tmpvar_17;
  tmpvar_17 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_2)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_2)
  ), (half)0.0, (half)1.0));
  tmpvar_10 = float(tmpvar_17);
  tmpvar_7 = half2(((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_11)).xy);
  float4 o_18;
  float4 tmpvar_19;
  tmpvar_19 = (tmpvar_4 * 0.5);
  float2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _mtl_u._ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_4.zw;
  tmpvar_8 = half4(o_18);
  _mtl_o.gl_Position = tmpvar_4;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_13).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_10;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_11.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 26 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
"ps_3_0
def c3, 4, -10, 1.00999999, -1
dcl_texcoord2 v0.xyz
dcl_texcoord4_pp v1.xyz
dcl_2d s0
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v1, r0
add_pp r0.y, r0.x, c3.z
mul_sat_pp r0.x, r0.x, c3.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, -c3.w
nrm_pp r0.xyz, c0
nrm_pp r2.xyz, v1
dp3_pp r0.x, r2, r0
mov r2.xyz, c2
mul_pp r0.yzw, r2.xxyz, c1.xxyz
mul r0.yzw, r0.x, r0
dp3 r1.y, v0, v0
texld_pp r2, r1.y, s0
mul r1.y, r2.x, c3.x
mul_pp r2, r0.yzwx, r1.y
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 24 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:abacabaa
eefiecedljiogdgbafjeimcibcijjlmlgknlokafabaaaaaakeaeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaanfaaaaaafjaaaaaeegiocaaa
aaaaaaaablaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
bbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaa
bkaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaeadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 32
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 24 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  half3 lightDir_6;
  lightDir_6 = half3(tmpvar_3);
  half3 normal_7;
  normal_7 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_8;
  atten_8 = tmpvar_5.w;
  half4 c_9;
  half3 tmpvar_10;
  tmpvar_10 = normalize(lightDir_6);
  lightDir_6 = tmpvar_10;
  half3 tmpvar_11;
  tmpvar_11 = normalize(normal_7);
  normal_7 = tmpvar_11;
  half tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, tmpvar_10);
  c_9.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_12) * (atten_8 * (half)4.0))));
  c_9.w = (tmpvar_12 * (atten_8 * (half)4.0));
  float3 tmpvar_13;
  tmpvar_13 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_14;
  lightDir_14 = half3(tmpvar_13);
  half3 normal_15;
  normal_15 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  color_2 = (c_9 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_16))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_16))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
"ps_3_0
def c3, 4, -10, 1.00999999, -1
dcl_texcoord4_pp v0.xyz
dp4_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v0, r0
add_pp r0.y, r0.x, c3.z
mul_sat_pp r0.x, r0.x, c3.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, -c3.w
nrm_pp r0.xyz, c0
nrm_pp r2.xyz, v0
dp3_pp r0.x, r2, r0
mov r2.xyz, c2
mul_pp r0.yzw, r2.xxyz, c1.xxyz
mul r0.yzw, r0.x, r0
mul_pp r2, r0.yzwx, c3.x
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 416
Vector 96 [_LightColor0]
Vector 352 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:aaacaaaa
eefiecedmdfhcpiihncgghflgehfipolpdhpfbehabaaaaaabeaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmacaaaaeaaaaaaalhaaaaaa
fjaaaaaeegiocaaaaaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
bbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
adaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaa
bgaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeadiaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaea
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 24
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  half3 normal_3;
  normal_3 = half3(_mtl_i.xlv_TEXCOORD4);
  half4 c_4;
  half3 tmpvar_5;
  tmpvar_5 = normalize(normal_3);
  normal_3 = tmpvar_5;
  half tmpvar_6;
  tmpvar_6 = dot (tmpvar_5, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  c_4.xyz = ((half3)((float3)(color_2.xyz * _mtl_u._LightColor0.xyz) * ((float)(tmpvar_6 * (half)4.0))));
  c_4.w = (tmpvar_6 * (half)4.0);
  half3 normal_7;
  normal_7 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_8;
  tmpvar_8 = dot (normal_7, normalize(_mtl_u._WorldSpaceLightPos0).xyz);
  color_2 = (c_4 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_8))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_8))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 31 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
"ps_3_0
def c3, 0.5, 4, 0, -10
def c4, 1.00999999, -1, 1, 0
dcl_texcoord2 v0
dcl_texcoord4_pp v1.xyz
dcl_2d s0
dcl_2d s1
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v1, r0
add_pp r0.y, r0.x, c4.x
mul_sat_pp r0.x, r0.x, c3.w
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
add_pp r0.y, r0.y, c4.y
mad_pp r0.x, r0.x, r0.y, c4.z
rcp r0.y, v0.w
mad r0.yz, v0.xxyw, r0.y, c3.x
texld_pp r1, r0.yzzw, s0
dp3 r0.y, v0, v0
texld_pp r2, r0.y, s1
mul r0.y, r1.w, r2.x
mul r0.y, r0.y, c3.y
cmp r0.y, -v0.z, c3.z, r0.y
nrm_pp r1.xyz, c0
nrm_pp r2.xyz, v1
dp3_pp r0.z, r2, r1
mov r1.xyz, c2
mul_pp r1.xyz, r1, c1
mul r1.xyz, r0.z, r1
mul_pp r2.w, r0.y, r0.z
mul_pp r2.xyz, r0.y, r1
mul_pp r0, r0.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 30 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:acacacaa
eefiecedkpmobpahobcohfbemghgiaaknplhdegcabaaaaaajiafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaaiaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceiaeaaaaeaaaaaaabcabaaaafjaaaaaeegiocaaa
aaaaaaaablaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaaj
bcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaah
gcaabaaaaaaaaaaaagbbbaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaa
efaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaadaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahecaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
kgakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajecaabaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaakgakbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 32
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 24 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  half4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _LightTextureB0 [[texture(1)]], sampler _mtlsmp__LightTextureB0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half4 tmpvar_4;
  half2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD2.xy / _mtl_i.xlv_TEXCOORD2.w) + (half)0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float3 LightCoord_6;
  LightCoord_6 = float3(_mtl_i.xlv_TEXCOORD2.xyz);
  float tmpvar_7;
  tmpvar_7 = dot (LightCoord_6, LightCoord_6);
  half4 tmpvar_8;
  tmpvar_8 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_7)));
  half3 lightDir_9;
  lightDir_9 = half3(tmpvar_3);
  half3 normal_10;
  normal_10 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_11;
  atten_11 = ((half(
    (_mtl_i.xlv_TEXCOORD2.z > (half)0.0)
  ) * tmpvar_4.w) * tmpvar_8.w);
  half4 c_12;
  half3 tmpvar_13;
  tmpvar_13 = normalize(lightDir_9);
  lightDir_9 = tmpvar_13;
  half3 tmpvar_14;
  tmpvar_14 = normalize(normal_10);
  normal_10 = tmpvar_14;
  half tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_13);
  c_12.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_15) * (atten_11 * (half)4.0))));
  c_12.w = (tmpvar_15 * (atten_11 * (half)4.0));
  float3 tmpvar_16;
  tmpvar_16 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_17;
  lightDir_17 = half3(tmpvar_16);
  half3 normal_18;
  normal_18 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  color_2 = (c_12 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_19))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_19))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 27 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
"ps_3_0
def c3, 4, -10, 1.00999999, -1
dcl_texcoord2 v0.xyz
dcl_texcoord4_pp v1.xyz
dcl_cube s0
dcl_2d s1
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v1, r0
add_pp r0.y, r0.x, c3.z
mul_sat_pp r0.x, r0.x, c3.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, -c3.w
nrm_pp r0.xyz, c0
nrm_pp r2.xyz, v1
dp3_pp r0.x, r2, r0
mov r2.xyz, c2
mul_pp r0.yzw, r2.xxyz, c1.xxyz
mul r0.yzw, r0.x, r0
dp3 r1.y, v0, v0
texld r2, r1.y, s1
texld r3, v0, s0
mul_pp r1.y, r2.x, r3.w
mul r1.y, r1.y, c3.x
mul_pp r2, r0.yzwx, r1.y
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 25 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:acacacaa
eefiecedhbbemhdbhnfoiolcfgolagnioogabbfkabaaaaaaaaafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclaadaaaaeaaaaaaaomaaaaaafjaaaaaeegiocaaa
aaaaaaaablaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabbaaaaaj
bcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaaj
ccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 32
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 24 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _LightTextureB0 [[texture(1)]], sampler _mtlsmp__LightTextureB0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD2));
  half3 lightDir_7;
  lightDir_7 = half3(tmpvar_3);
  half3 normal_8;
  normal_8 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_9;
  atten_9 = (tmpvar_5.w * tmpvar_6.w);
  half4 c_10;
  half3 tmpvar_11;
  tmpvar_11 = normalize(lightDir_7);
  lightDir_7 = tmpvar_11;
  half3 tmpvar_12;
  tmpvar_12 = normalize(normal_8);
  normal_8 = tmpvar_12;
  half tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, tmpvar_11);
  c_10.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_13) * (atten_9 * (half)4.0))));
  c_10.w = (tmpvar_13 * (atten_9 * (half)4.0));
  float3 tmpvar_14;
  tmpvar_14 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_15;
  lightDir_15 = half3(tmpvar_14);
  half3 normal_16;
  normal_16 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  color_2 = (c_10 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_17))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_17))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 25 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
"ps_3_0
def c3, 4, -10, 1.00999999, -1
dcl_texcoord2 v0.xy
dcl_texcoord4_pp v1.xyz
dcl_2d s0
dp4_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v1, r0
add_pp r0.y, r0.x, c3.z
mul_sat_pp r0.x, r0.x, c3.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, -c3.w
nrm_pp r0.xyz, c0
nrm_pp r2.xyz, v1
dp3_pp r0.x, r2, r0
mov r2.xyz, c2
mul_pp r0.yzw, r2.xxyz, c1.xxyz
mul r0.yzw, r0.x, r0
texld_pp r2, v0, s0
mul r1.y, r2.w, c3.x
mul_pp r2, r0.yzwx, r1.y
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 23 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:abacabaa
eefiecedcebdldeplkpfebcjcicicdijcjgaaboiabaaaaaaiiaeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaeaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdiadaaaaeaaaaaaamoaaaaaafjaaaaaeegiocaaa
aaaaaaaablaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
bbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaa
bkaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiaea
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 24
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  half4 tmpvar_3;
  tmpvar_3 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(_mtl_i.xlv_TEXCOORD2));
  half3 normal_4;
  normal_4 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_5;
  atten_5 = tmpvar_3.w;
  half4 c_6;
  half3 tmpvar_7;
  tmpvar_7 = normalize(normal_4);
  normal_4 = tmpvar_7;
  half tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  c_6.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_8) * (atten_5 * (half)4.0))));
  c_6.w = (tmpvar_8 * (atten_5 * (half)4.0));
  half3 normal_9;
  normal_9 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_10;
  tmpvar_10 = dot (normal_9, normalize(_mtl_u._WorldSpaceLightPos0).xyz);
  color_2 = (c_6 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_10))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_10))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 35 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 3 [_Color]
Vector 2 [_LightColor0]
Vector 1 [_LightShadowData]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
def c4, 0.5, 0, 1, 4
def c5, -10, 1.00999999, 0, 0
dcl_texcoord2 v0
dcl_texcoord3 v1
dcl_texcoord4_pp v2.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c5.y
mul_sat_pp r0.x, r0.x, c5.x
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, c4.z
rcp r0.x, v0.w
mad r0.xy, v0, r0.x, c4.x
texld_pp r0, r0, s1
dp3 r0.x, v0, v0
texld_pp r2, r0.x, s2
mul r0.x, r0.w, r2.x
cmp r0.x, -v0.z, c4.y, r0.x
texldp_pp r2, v1, s0
mov r0.z, c4.z
lrp_pp r1.y, r2.x, r0.z, c1.x
mul_pp r0.x, r0.x, r1.y
mul r0.x, r0.x, c4.w
nrm_pp r2.xyz, c0
nrm_pp r3.xyz, v2
dp3_pp r0.y, r3, r2
mov r2.xyz, c3
mul_pp r1.yzw, r2.xxyz, c2.xxyz
mul r1.yzw, r0.y, r1
mul_pp r2.w, r0.x, r0.y
mul_pp r2.xyz, r0.x, r1.yzww
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 34 math, 2 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_LightTextureB0] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
root12:adadadaa
eefiecedngglimjjdeihicclpkhhdpfjjinljpihabaaaaaajiagaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
aiaaaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdaafaaaaeaaaaaaaemabaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaahgcaabaaaaaaaaaaaagbbbaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahhcaabaaaabaaaaaaegbcbaaaaeaaaaaapgbpbaaaaeaaaaaa
ehaaaaalecaabaaaaaaaaaaaegaabaaaabaaaaaaaghabaaaacaaaaaaaagabaaa
aaaaaaaackaabaaaabaaaaaaaaaaaaajicaabaaaaaaaaaaaakiacaiaebaaaaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaadiaaaaahccaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajecaabaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaakgakbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 31 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 40
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightShadowData] 4
VectorHalf 24 [_LightColor0] 4
VectorHalf 32 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  half4 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]]
  ,   texture2d<half> _LightTextureB0 [[texture(2)]], sampler _mtlsmp__LightTextureB0 [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half4 tmpvar_4;
  half2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD2.xy / _mtl_i.xlv_TEXCOORD2.w) + (half)0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  half tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD2.xyz, _mtl_i.xlv_TEXCOORD2.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(half2(tmpvar_6)));
  half tmpvar_8;
  float4 shadowCoord_9;
  shadowCoord_9 = float4(_mtl_i.xlv_TEXCOORD3);
  half shadow_10;
  half tmpvar_11;
  tmpvar_11 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(shadowCoord_9).xy / (float)(shadowCoord_9).w, (float)(shadowCoord_9).z / (float)(shadowCoord_9).w);
  shadow_10 = (_mtl_u._LightShadowData.x + (tmpvar_11 * ((half)1.0 - _mtl_u._LightShadowData.x)));
  tmpvar_8 = shadow_10;
  half3 lightDir_12;
  lightDir_12 = half3(tmpvar_3);
  half3 normal_13;
  normal_13 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_14;
  atten_14 = (((
    half((_mtl_i.xlv_TEXCOORD2.z > (half)0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  half4 c_15;
  half3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  half3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  half tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  c_15.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_18) * (atten_14 * (half)4.0))));
  c_15.w = (tmpvar_18 * (atten_14 * (half)4.0));
  float3 tmpvar_19;
  tmpvar_19 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_20;
  lightDir_20 = half3(tmpvar_19);
  half3 normal_21;
  normal_21 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  color_2 = (c_15 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_22))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_22))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 25 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
"ps_3_0
def c3, 4, -10, 1.00999999, -1
dcl_texcoord2 v0
dcl_texcoord4_pp v1.xyz
dcl_2d s0
dp4_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v1, r0
add_pp r0.y, r0.x, c3.z
mul_sat_pp r0.x, r0.x, c3.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, -c3.w
nrm_pp r0.xyz, c0
nrm_pp r2.xyz, v1
dp3_pp r0.x, r2, r0
mov r2.xyz, c2
mul_pp r0.yzw, r2.xxyz, c1.xxyz
mul r0.yzw, r0.x, r0
texldp_pp r2, v0, s0
mul r1.y, r2.x, c3.x
mul_pp r2, r0.yzwx, r1.y
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
SetTexture 0 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 416
Vector 96 [_LightColor0]
Vector 352 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:abacabaa
eefiecedaolgpjenognlmfbmfolmfollacnmdkciabaaaaaakeaeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaaiaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaanfaaaaaafjaaaaaeegiocaaa
aaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
bbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaa
bgaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
aoaaaaahmcaabaaaaaaaaaaaagbebaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaeadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 26 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
def c3, 4, -10, 1.00999999, -1
dcl_texcoord2 v0.xy
dcl_texcoord3 v1
dcl_texcoord4_pp v2.xyz
dcl_2d s0
dcl_2d s1
dp4_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c3.z
mul_sat_pp r0.x, r0.x, c3.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, -c3.w
nrm_pp r0.xyz, c0
nrm_pp r2.xyz, v2
dp3_pp r0.x, r2, r0
mov r2.xyz, c2
mul_pp r0.yzw, r2.xxyz, c1.xxyz
mul r0.yzw, r0.x, r0
texld r2, v0, s1
texldp_pp r3, v1, s0
mul_pp r1.y, r2.w, r3.x
mul r1.y, r1.y, c3.x
mul_pp r2, r0.yzwx, r1.y
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:acacacaa
eefiecedncggchgaenjchokpgeekphkdhbfhcnnmabaaaaaaceafaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaeaaaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclmadaaaaeaaaaaaaopaaaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
bbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
afaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaa
bkaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
aoaaaaahmcaabaaaaaaaaaaaagbebaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 35 math, 2 textures
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 4 [_Color]
Vector 3 [_LightColor0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
def c5, 0.970000029, 1, 4, -10
def c6, 1.00999999, 0, 0, 0
dcl_texcoord2 v0.xyz
dcl_texcoord3 v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_cube s0
dcl_2d s1
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c6.x
mul_sat_pp r0.x, r0.x, c5.w
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, c5.y
dp3 r0.x, v1, v1
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c1.w
texld r2, v1, s0
mad r0.x, r0.x, -c5.x, r2.x
mov r0.y, c5.y
cmp_pp r0.x, r0.x, r0.y, c2.x
dp3 r0.y, v0, v0
texld r2, r0.y, s1
mul_pp r0.x, r0.x, r2.x
mul r0.x, r0.x, c5.z
nrm_pp r2.xyz, c0
nrm_pp r3.xyz, v2
dp3_pp r0.y, r3, r2
mov r2.xyz, c4
mul_pp r1.yzw, r2.xxyz, c3.xxyz
mul r1.yzw, r0.y, r1
mul_pp r2.w, r0.x, r0.y
mul_pp r2.xyz, r0.x, r1.yzww
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 30 math, 2 textures
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
root12:acadacaa
eefiecedookphfjndemfbjjepfdjflakfgmpamiiabaaaaaaoeafaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchmaeaaaaeaaaaaaabpabaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdp
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaabaaaaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaomfbhidpefaaaaaj
pcaabaaaabaaaaaaegbcbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
dbaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaadhaaaaak
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaaabeaaaaa
aaaaiadpbaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaaj
ecaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
icaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 28 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 56
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
VectorHalf 32 [_LightShadowData] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  half4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  float mydist_6;
  mydist_6 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float4 tmpvar_7;
  tmpvar_7 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(_mtl_i.xlv_TEXCOORD3));
  half tmpvar_8;
  if ((tmpvar_7.x < mydist_6)) {
    tmpvar_8 = _mtl_u._LightShadowData.x;
  } else {
    tmpvar_8 = half(1.0);
  };
  half3 lightDir_9;
  lightDir_9 = half3(tmpvar_3);
  half3 normal_10;
  normal_10 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_11;
  atten_11 = (tmpvar_5.w * tmpvar_8);
  half4 c_12;
  half3 tmpvar_13;
  tmpvar_13 = normalize(lightDir_9);
  lightDir_9 = tmpvar_13;
  half3 tmpvar_14;
  tmpvar_14 = normalize(normal_10);
  normal_10 = tmpvar_14;
  half tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_13);
  c_12.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_15) * (atten_11 * (half)4.0))));
  c_12.w = (tmpvar_15 * (atten_11 * (half)4.0));
  float3 tmpvar_16;
  tmpvar_16 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_17;
  lightDir_17 = half3(tmpvar_16);
  half3 normal_18;
  normal_18 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  color_2 = (c_12 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_19))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_19))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 36 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 4 [_Color]
Vector 3 [_LightColor0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
def c5, 0.970000029, 1, 4, -10
def c6, 1.00999999, 0, 0, 0
dcl_texcoord2 v0.xyz
dcl_texcoord3 v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c6.x
mul_sat_pp r0.x, r0.x, c5.w
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, c5.y
dp3 r0.x, v1, v1
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c1.w
texld r2, v1, s0
mad r0.x, r0.x, -c5.x, r2.x
mov r0.y, c5.y
cmp_pp r0.x, r0.x, r0.y, c2.x
dp3 r0.y, v0, v0
texld r2, r0.y, s2
texld r3, v0, s1
mul r0.y, r2.x, r3.w
mul_pp r0.x, r0.x, r0.y
mul r0.x, r0.x, c5.z
nrm_pp r2.xyz, c0
nrm_pp r3.xyz, v2
dp3_pp r0.y, r3, r2
mov r2.xyz, c4
mul_pp r1.yzw, r2.xxyz, c3.xxyz
mul r1.yzw, r0.y, r1
mul_pp r2.w, r0.x, r0.y
mul_pp r2.xyz, r0.x, r1.yzww
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 31 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_LightTextureB0] 2D 2
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
root12:adadadaa
eefiecedpcdcpcddpccoejkbenchdkbknbmmgbliabaaaaaaeaagaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcniaeaaaaeaaaaaaadgabaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaomfbhidpefaaaaajpcaabaaa
abaaaaaaegbcbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaadhaaaaakccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadp
baaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajecaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
acaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 29 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 56
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
VectorHalf 32 [_LightShadowData] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  half4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texturecube<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]]
  ,   texture2d<half> _LightTextureB0 [[texture(2)]], sampler _mtlsmp__LightTextureB0 [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD2));
  float mydist_7;
  mydist_7 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float4 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(_mtl_i.xlv_TEXCOORD3));
  half tmpvar_9;
  if ((tmpvar_8.x < mydist_7)) {
    tmpvar_9 = _mtl_u._LightShadowData.x;
  } else {
    tmpvar_9 = half(1.0);
  };
  half3 lightDir_10;
  lightDir_10 = half3(tmpvar_3);
  half3 normal_11;
  normal_11 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_12;
  atten_12 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_9);
  half4 c_13;
  half3 tmpvar_14;
  tmpvar_14 = normalize(lightDir_10);
  lightDir_10 = tmpvar_14;
  half3 tmpvar_15;
  tmpvar_15 = normalize(normal_11);
  normal_11 = tmpvar_15;
  half tmpvar_16;
  tmpvar_16 = dot (tmpvar_15, tmpvar_14);
  c_13.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_16) * (atten_12 * (half)4.0))));
  c_13.w = (tmpvar_16 * (atten_12 * (half)4.0));
  float3 tmpvar_17;
  tmpvar_17 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_18;
  lightDir_18 = half3(tmpvar_17);
  half3 normal_19;
  normal_19 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_20;
  tmpvar_20 = dot (normal_19, lightDir_18);
  color_2 = (c_13 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_20))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_20))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 44 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 7 [_Color]
Vector 6 [_LightColor0]
Vector 5 [_LightShadowData]
Vector 0 [_ShadowOffsets0]
Vector 1 [_ShadowOffsets1]
Vector 2 [_ShadowOffsets2]
Vector 3 [_ShadowOffsets3]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
def c8, 0.5, 0, 1, 0.25
def c9, 4, -10, 1.00999999, 0
dcl_texcoord2 v0
dcl_texcoord3 v1
dcl_texcoord4_pp v2.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dp4 r0.x, c4, c4
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c4
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c9.z
mul_sat_pp r0.x, r0.x, c9.y
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, c8.z
mov r0.z, c8.z
rcp r0.x, v1.w
mad r2, v1, r0.x, c0
texldp_pp r2, r2, s0
mad r3, v1, r0.x, c1
texldp_pp r3, r3, s0
mov_pp r2.y, r3.x
mad r3, v1, r0.x, c2
mad r4, v1, r0.x, c3
texldp_pp r4, r4, s0
mov_pp r2.w, r4.x
texldp_pp r3, r3, s0
mov_pp r2.z, r3.x
lrp_pp r3, r2, r0.z, c5.x
dp4_pp r0.x, r3, c8.w
rcp r0.y, v0.w
mad r0.yz, v0.xxyw, r0.y, c8.x
texld_pp r2, r0.yzzw, s1
dp3 r0.y, v0, v0
texld_pp r3, r0.y, s2
mul r0.y, r2.w, r3.x
cmp r0.y, -v0.z, c8.y, r0.y
mul_pp r0.x, r0.x, r0.y
mul r0.x, r0.x, c9.x
nrm_pp r2.xyz, c4
nrm_pp r3.xyz, v2
dp3_pp r0.y, r3, r2
mov r2.xyz, c7
mul_pp r1.yzw, r2.xxyz, c6.xxyz
mul r1.yzw, r0.y, r1
mul_pp r2.w, r0.x, r0.y
mul_pp r2.xyz, r0.x, r1.yzww
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 39 math, 2 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_LightTextureB0] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 544
Vector 96 [_ShadowOffsets0]
Vector 112 [_ShadowOffsets1]
Vector 128 [_ShadowOffsets2]
Vector 144 [_ShadowOffsets3]
Vector 224 [_LightColor0]
Vector 480 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
root12:adadadaa
eefiecedojffkcleglojolgiklhnelpkmflkkijiabaaaaaameahaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
aiaaaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfmagaaaaeaaaaaaajhabaaaafjaaaaaeegiocaaaaaaaaaaabpaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpaoaaaaahocaabaaaaaaaaaaaagbjbaaa
aeaaaaaapgbpbaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaehaaaaalbcaabaaaabaaaaaaegaabaaaabaaaaaa
aghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaaabaaaaaaaaaaaaaihcaabaaa
acaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaaehaaaaalccaabaaa
abaaaaaaegaabaaaacaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
ajaaaaaaehaaaaalicaabaaaabaaaaaajgafbaaaaaaaaaaaaghabaaaacaaaaaa
aagabaaaaaaaaaaadkaabaaaaaaaaaaaehaaaaalecaabaaaabaaaaaaegaabaaa
acaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaaagiacaaaacaaaaaa
biaaaaaabbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadoaoaaaaahgcaabaaaaaaaaaaaagbbbaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaaj
ccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaaegiccaaaaaaaaaaaboaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
icaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajbcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaa
egacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
koehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacamb
ebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 37 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 112
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightShadowData] 4
Vector 32 [_ShadowOffsets0]
Vector 48 [_ShadowOffsets1]
Vector 64 [_ShadowOffsets2]
Vector 80 [_ShadowOffsets3]
VectorHalf 96 [_LightColor0] 4
VectorHalf 104 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  half4 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightShadowData;
  float4 _ShadowOffsets[4];
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]]
  ,   texture2d<half> _LightTextureB0 [[texture(2)]], sampler _mtlsmp__LightTextureB0 [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half4 tmpvar_4;
  half2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD2.xy / _mtl_i.xlv_TEXCOORD2.w) + (half)0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  half tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD2.xyz, _mtl_i.xlv_TEXCOORD2.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(half2(tmpvar_6)));
  half tmpvar_8;
  float4 shadowCoord_9;
  shadowCoord_9 = float4(_mtl_i.xlv_TEXCOORD3);
  half4 shadows_10;
  float3 tmpvar_11;
  tmpvar_11 = (shadowCoord_9.xyz / shadowCoord_9.w);
  float3 coord_12;
  coord_12 = (tmpvar_11 + _mtl_u._ShadowOffsets[0].xyz);
  half tmpvar_13;
  tmpvar_13 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_12).xy, (float)(coord_12).z);
  shadows_10.x = tmpvar_13;
  float3 coord_14;
  coord_14 = (tmpvar_11 + _mtl_u._ShadowOffsets[1].xyz);
  half tmpvar_15;
  tmpvar_15 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_14).xy, (float)(coord_14).z);
  shadows_10.y = tmpvar_15;
  float3 coord_16;
  coord_16 = (tmpvar_11 + _mtl_u._ShadowOffsets[2].xyz);
  half tmpvar_17;
  tmpvar_17 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_16).xy, (float)(coord_16).z);
  shadows_10.z = tmpvar_17;
  float3 coord_18;
  coord_18 = (tmpvar_11 + _mtl_u._ShadowOffsets[3].xyz);
  half tmpvar_19;
  tmpvar_19 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_18).xy, (float)(coord_18).z);
  shadows_10.w = tmpvar_19;
  shadows_10 = (_mtl_u._LightShadowData.xxxx + (shadows_10 * ((half)1.0 - _mtl_u._LightShadowData.xxxx)));
  half tmpvar_20;
  tmpvar_20 = dot (shadows_10, (half4)float4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_20;
  half3 lightDir_21;
  lightDir_21 = half3(tmpvar_3);
  half3 normal_22;
  normal_22 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_23;
  atten_23 = (((
    half((_mtl_i.xlv_TEXCOORD2.z > (half)0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  half4 c_24;
  half3 tmpvar_25;
  tmpvar_25 = normalize(lightDir_21);
  lightDir_21 = tmpvar_25;
  half3 tmpvar_26;
  tmpvar_26 = normalize(normal_22);
  normal_22 = tmpvar_26;
  half tmpvar_27;
  tmpvar_27 = dot (tmpvar_26, tmpvar_25);
  c_24.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_27) * (atten_23 * (half)4.0))));
  c_24.w = (tmpvar_27 * (atten_23 * (half)4.0));
  float3 tmpvar_28;
  tmpvar_28 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_29;
  lightDir_29 = half3(tmpvar_28);
  half3 normal_30;
  normal_30 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_31;
  tmpvar_31 = dot (normal_30, lightDir_29);
  color_2 = (c_24 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_31))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_31))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 43 math, 5 textures
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 4 [_Color]
Vector 3 [_LightColor0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
def c5, 0.0078125, -0.0078125, 0.970000029, 1
def c6, 0.25, 4, -10, 1.00999999
dcl_texcoord2 v0.xyz
dcl_texcoord3 v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_cube s0
dcl_2d s1
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c6.w
mul_sat_pp r0.x, r0.x, c6.z
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, c5.w
dp3 r0.x, v1, v1
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c1.w
add r0.yzw, c5.x, v1.xxyz
texld r2, r0.yzww, s0
add r0.yzw, c5.xyyx, v1.xxyz
texld r3, r0.yzww, s0
mov r2.y, r3.x
add r0.yzw, c5.xyxy, v1.xxyz
texld r3, r0.yzww, s0
mov r2.z, r3.x
add r0.yzw, c5.xxyy, v1.xxyz
texld r3, r0.yzww, s0
mov r2.w, r3.x
mad r0, r0.x, -c5.z, r2
mov r1.w, c5.w
cmp_pp r0, r0, r1.w, c2.x
dp4_pp r0.x, r0, c6.x
dp3 r0.y, v0, v0
texld r2, r0.y, s1
mul_pp r0.x, r0.x, r2.x
mul r0.x, r0.x, c6.y
nrm_pp r2.xyz, c0
nrm_pp r3.xyz, v2
dp3_pp r0.y, r3, r2
mov r2.xyz, c4
mul_pp r1.yzw, r2.xxyz, c3.xxyz
mul r1.yzw, r0.y, r1
mul_pp r2.w, r0.x, r0.y
mul_pp r2.xyz, r0.x, r1.yzww
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 35 math, 5 textures
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
root12:acadacaa
eefiecedjlilkendgkbmlcllgannallanphfnnemabaaaaaagaahaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiafaaaaeaaaaaaahoabaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidpaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaadm
aaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaalmaaaaaalmaaaaaadmefaaaaajpcaabaaaacaaaaaajgahbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadgaaaaafccaabaaaabaaaaaa
akaabaaaacaaaaaaaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaa
akaabaaaacaaaaaaaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaadmaaaaaalmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaa
akaabaaaacaaaaaadbaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaa
aaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaacaaaaaa
biaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiado
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajccaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
acaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdp
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 36 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 56
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
VectorHalf 32 [_LightShadowData] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  half4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  float4 shadowVals_6;
  float mydist_7;
  mydist_7 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  shadowVals_6.x = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, 0.0078125, 0.0078125)))).x;
  shadowVals_6.y = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, -0.0078125, 0.0078125)))).x;
  shadowVals_6.z = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, 0.0078125, -0.0078125)))).x;
  shadowVals_6.w = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, -0.0078125, -0.0078125)))).x;
  bool4 tmpvar_8;
  tmpvar_8 = bool4((shadowVals_6 < float4(mydist_7)));
  half4 tmpvar_9;
  tmpvar_9 = _mtl_u._LightShadowData.xxxx;
  half tmpvar_10;
  if (tmpvar_8.x) {
    tmpvar_10 = tmpvar_9.x;
  } else {
    tmpvar_10 = half(1.0);
  };
  half tmpvar_11;
  if (tmpvar_8.y) {
    tmpvar_11 = tmpvar_9.y;
  } else {
    tmpvar_11 = half(1.0);
  };
  half tmpvar_12;
  if (tmpvar_8.z) {
    tmpvar_12 = tmpvar_9.z;
  } else {
    tmpvar_12 = half(1.0);
  };
  half tmpvar_13;
  if (tmpvar_8.w) {
    tmpvar_13 = tmpvar_9.w;
  } else {
    tmpvar_13 = half(1.0);
  };
  half4 tmpvar_14;
  tmpvar_14.x = tmpvar_10;
  tmpvar_14.y = tmpvar_11;
  tmpvar_14.z = tmpvar_12;
  tmpvar_14.w = tmpvar_13;
  half3 lightDir_15;
  lightDir_15 = half3(tmpvar_3);
  half3 normal_16;
  normal_16 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_17;
  atten_17 = (tmpvar_5.w * dot (tmpvar_14, (half4)float4(0.25, 0.25, 0.25, 0.25)));
  half4 c_18;
  half3 tmpvar_19;
  tmpvar_19 = normalize(lightDir_15);
  lightDir_15 = tmpvar_19;
  half3 tmpvar_20;
  tmpvar_20 = normalize(normal_16);
  normal_16 = tmpvar_20;
  half tmpvar_21;
  tmpvar_21 = dot (tmpvar_20, tmpvar_19);
  c_18.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_21) * (atten_17 * (half)4.0))));
  c_18.w = (tmpvar_21 * (atten_17 * (half)4.0));
  float3 tmpvar_22;
  tmpvar_22 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_23;
  lightDir_23 = half3(tmpvar_22);
  half3 normal_24;
  normal_24 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_25;
  tmpvar_25 = dot (normal_24, lightDir_23);
  color_2 = (c_18 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_25))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_25))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 44 math, 6 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 4 [_Color]
Vector 3 [_LightColor0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
def c5, 0.0078125, -0.0078125, 0.970000029, 1
def c6, 0.25, 4, -10, 1.00999999
dcl_texcoord2 v0.xyz
dcl_texcoord3 v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dp4 r0.x, c0, c0
rsq r0.x, r0.x
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.x, v2, r0
add_pp r0.y, r0.x, c6.w
mul_sat_pp r0.x, r0.x, c6.z
frc_pp r0.z, r0.y
add_sat_pp r0.y, -r0.z, r0.y
lrp_pp r1.x, r0.x, r0.y, c5.w
dp3 r0.x, v1, v1
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c1.w
add r0.yzw, c5.x, v1.xxyz
texld r2, r0.yzww, s0
add r0.yzw, c5.xyyx, v1.xxyz
texld r3, r0.yzww, s0
mov r2.y, r3.x
add r0.yzw, c5.xyxy, v1.xxyz
texld r3, r0.yzww, s0
mov r2.z, r3.x
add r0.yzw, c5.xxyy, v1.xxyz
texld r3, r0.yzww, s0
mov r2.w, r3.x
mad r0, r0.x, -c5.z, r2
mov r1.w, c5.w
cmp_pp r0, r0, r1.w, c2.x
dp4_pp r0.x, r0, c6.x
dp3 r0.y, v0, v0
texld r2, r0.y, s2
texld r3, v0, s1
mul r0.y, r2.x, r3.w
mul_pp r0.x, r0.x, r0.y
mul r0.x, r0.x, c6.y
nrm_pp r2.xyz, c0
nrm_pp r3.xyz, v2
dp3_pp r0.y, r3, r2
mov r2.xyz, c4
mul_pp r1.yzw, r2.xxyz, c3.xxyz
mul r1.yzw, r0.y, r1
mul_pp r2.w, r0.x, r0.y
mul_pp r2.xyz, r0.x, r1.yzww
mul_pp r0, r1.x, r2
mul_pp oC0.xyz, r0.w, r0
mov_pp oC0.w, r0.w

"
}
SubProgram "d3d11 " {
// Stats: 36 math, 6 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_LightTextureB0] 2D 2
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 480
Vector 160 [_LightColor0]
Vector 416 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
root12:adadadaa
eefiecedjepffnmkfmadepcgfgdnemlbccepmaonabaaaaaalmahaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfeagaaaaeaaaaaaajfabaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidpaaaaaaakocaabaaa
aaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaadmaaaaaadm
efaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaalmaaaaaalmaaaaaadmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaadgaaaaafccaabaaaabaaaaaaakaabaaa
acaaaaaaaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaa
acaaaaaaaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaadmaaaaaalmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaa
acaaaaaadbaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaa
dhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaacaaaaaabiaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbbaaaaakbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadobaaaaaah
ccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajccaabaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaaegiccaaaaaaaaaaabkaaaaaadiaaaaahhcaabaaa
abaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 37 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 56
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
VectorHalf 32 [_LightShadowData] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  half4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texturecube<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]]
  ,   texture2d<half> _LightTextureB0 [[texture(2)]], sampler _mtlsmp__LightTextureB0 [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD2));
  float4 shadowVals_7;
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  shadowVals_7.x = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, 0.0078125, 0.0078125)))).x;
  shadowVals_7.y = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, -0.0078125, 0.0078125)))).x;
  shadowVals_7.z = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, 0.0078125, -0.0078125)))).x;
  shadowVals_7.w = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)((_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, -0.0078125, -0.0078125)))).x;
  bool4 tmpvar_9;
  tmpvar_9 = bool4((shadowVals_7 < float4(mydist_8)));
  half4 tmpvar_10;
  tmpvar_10 = _mtl_u._LightShadowData.xxxx;
  half tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = half(1.0);
  };
  half tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = half(1.0);
  };
  half tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = half(1.0);
  };
  half tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = half(1.0);
  };
  half4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  half3 lightDir_16;
  lightDir_16 = half3(tmpvar_3);
  half3 normal_17;
  normal_17 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_18;
  atten_18 = ((tmpvar_5.w * tmpvar_6.w) * dot (tmpvar_15, (half4)float4(0.25, 0.25, 0.25, 0.25)));
  half4 c_19;
  half3 tmpvar_20;
  tmpvar_20 = normalize(lightDir_16);
  lightDir_16 = tmpvar_20;
  half3 tmpvar_21;
  tmpvar_21 = normalize(normal_17);
  normal_17 = tmpvar_21;
  half tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, tmpvar_20);
  c_19.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_22) * (atten_18 * (half)4.0))));
  c_19.w = (tmpvar_22 * (atten_18 * (half)4.0));
  float3 tmpvar_23;
  tmpvar_23 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_24;
  lightDir_24 = half3(tmpvar_23);
  half3 normal_25;
  normal_25 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_26;
  tmpvar_26 = dot (normal_25, lightDir_24);
  color_2 = (c_19 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_26))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_26))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 24
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  half4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  half tmpvar_3;
  tmpvar_3 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, ((float2)(_mtl_i.xlv_TEXCOORD2).xy / (float)(_mtl_i.xlv_TEXCOORD2).w)).x;
  half3 normal_4;
  normal_4 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_5;
  atten_5 = tmpvar_3;
  half4 c_6;
  half3 tmpvar_7;
  tmpvar_7 = normalize(normal_4);
  normal_4 = tmpvar_7;
  half tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  c_6.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_8) * (atten_5 * (half)4.0))));
  c_6.w = (tmpvar_8 * (atten_5 * (half)4.0));
  half3 normal_9;
  normal_9 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_10;
  tmpvar_10 = dot (normal_9, normalize(_mtl_u._WorldSpaceLightPos0).xyz);
  color_2 = (c_6 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_10))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_10))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 21 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 24
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  half2 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  half4 tmpvar_3;
  tmpvar_3 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(_mtl_i.xlv_TEXCOORD2));
  half4 tmpvar_4;
  tmpvar_4 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, ((float2)(_mtl_i.xlv_TEXCOORD3).xy / (float)(_mtl_i.xlv_TEXCOORD3).w));
  half3 normal_5;
  normal_5 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_6;
  atten_6 = (tmpvar_3.w * tmpvar_4.x);
  half4 c_7;
  half3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  half tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  c_7.xyz = half3(((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_9) * (atten_6 * (half)4.0))));
  c_7.w = (tmpvar_9 * (atten_6 * (half)4.0));
  half3 normal_10;
  normal_10 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_11;
  tmpvar_11 = dot (normal_10, normalize(_mtl_u._WorldSpaceLightPos0).xyz);
  color_2 = (c_7 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_11))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_11))
  , (half)0.0, (half)1.0)));
  color_2.xyz = (color_2.xyz * color_2.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
}
 }
}
}