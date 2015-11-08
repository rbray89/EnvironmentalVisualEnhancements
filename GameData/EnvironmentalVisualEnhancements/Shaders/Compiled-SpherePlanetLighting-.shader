// Compiled shader for all platforms, uncompressed size: 356.7KB

Shader "EVE/PlanetLight" {
Properties {
 _Color ("Color Tint", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderMode"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 21 math
 //        d3d9 : 23 math
 //        gles : 28 avg math (18..41), 2 avg texture (0..6), 0 avg branch (0..4)
 //       gles3 : 27 avg math (18..41), 2 avg texture (0..6), 0 avg branch (0..4)
 //   glesdesktop : 28 avg math (18..41), 2 avg texture (0..6), 1 avg branch (0..4)
 //       metal : 12 math
 //      opengl : 28 avg math (18..41), 2 avg texture (0..6), 1 avg branch (0..4)
 // Stats for Fragment shader:
 //       d3d11 : 29 avg math (22..40), 2 avg texture (0..6)
 //        d3d9 : 35 avg math (25..46), 2 avg texture (0..6)
 //       metal : 27 avg math (18..41), 2 avg texture (0..6), 0 avg branch (0..4)
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderMode"="Transparent" }
  Lighting On
  ZWrite Off
  Blend SrcColor SrcAlpha, One Zero
Program "vp" {
SubProgram "opengl " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))).w;
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhflpoahochcnnnhlfgknaokaoinoejfeabaaaaaahmaeaaaaadaaaaaa
cmaaaaaajmaaaaaagmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaa
agajbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  mediump vec3 lightDir_6;
  lightDir_6 = tmpvar_3;
  mediump vec3 normal_7;
  normal_7 = xlv_TEXCOORD3;
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
  highp vec3 tmpvar_13;
  tmpvar_13 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.xyz = tmpvar_13;
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * tmpvar_18.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  mediump vec3 lightDir_6;
  lightDir_6 = tmpvar_3;
  mediump vec3 normal_7;
  normal_7 = xlv_TEXCOORD3;
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
  highp vec3 tmpvar_13;
  tmpvar_13 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.xyz = tmpvar_13;
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * tmpvar_18.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 21 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightTexture0, vec2(tmpvar_4));
  mediump vec3 lightDir_6;
  lightDir_6 = tmpvar_3;
  mediump vec3 normal_7;
  normal_7 = xlv_TEXCOORD3;
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
  highp vec3 tmpvar_13;
  tmpvar_13 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.xyz = tmpvar_13;
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * tmpvar_18.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float3 xlv_TEXCOORD6;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_3 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_3 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD1 = normalize((tmpvar_2 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_2 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 color_1;
  vec4 c_2;
  float tmpvar_3;
  tmpvar_3 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_2.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_3) * 4.0);
  c_2.w = (tmpvar_3 * 4.0);
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_5;
  tmpvar_5 = (c_2 * mix (1.0, clamp (
    floor((1.01 + tmpvar_4))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_4))
  , 0.0, 1.0)));
  color_1.w = tmpvar_5.w;
  color_1.xyz = (tmpvar_5.xyz * tmpvar_5.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmomjjfofdhffjpgkldonlpklgidhkjoaabaaaaaageaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaiadaaaaeaaaabaa
mcaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaa
elaaaaafbccabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaa
pgapbaaaabaaaaaaagajbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaa
aaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD1 = normalize((tmpvar_2 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_2 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_4;
  lightDir_4 = tmpvar_3;
  mediump vec3 normal_5;
  normal_5 = xlv_TEXCOORD3;
  mediump vec4 c_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(lightDir_4);
  lightDir_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, tmpvar_7);
  highp vec3 tmpvar_10;
  tmpvar_10 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_9) * 4.0);
  c_6.xyz = tmpvar_10;
  c_6.w = (tmpvar_9 * 4.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_11;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD1 = normalize((tmpvar_2 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_2 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_4;
  lightDir_4 = tmpvar_3;
  mediump vec3 normal_5;
  normal_5 = xlv_TEXCOORD3;
  mediump vec4 c_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(lightDir_4);
  lightDir_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, tmpvar_7);
  highp vec3 tmpvar_10;
  tmpvar_10 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_9) * 4.0);
  c_6.xyz = tmpvar_10;
  c_6.w = (tmpvar_9 * 4.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_11;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD1 = normalize((tmpvar_2 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_2 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_4;
  lightDir_4 = tmpvar_3;
  mediump vec3 normal_5;
  normal_5 = xlv_TEXCOORD3;
  mediump vec4 c_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(lightDir_4);
  lightDir_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, tmpvar_7);
  highp vec3 tmpvar_10;
  tmpvar_10 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_9) * 4.0);
  c_6.xyz = tmpvar_10;
  c_6.w = (tmpvar_9 * 4.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_11;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  tmpvar_2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_3, tmpvar_3));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_2 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_2 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = ((float(
    (xlv_TEXCOORD6.z > 0.0)
  ) * texture2D (_LightTexture0, (
    (xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w)
   + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz))).w);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednhdkonffncdkjoockihahemhocakflijabaaaaaahmaeaaaaadaaaaaa
cmaaaaaajmaaaaaagmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaa
agajbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD3;
  mediump float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD6.z > 0.0)
  ) * tmpvar_4.w) * tmpvar_7.w);
  mediump vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_10 * 4.0));
  c_11.xyz = tmpvar_15;
  c_11.w = (tmpvar_14 * (atten_10 * 4.0));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD3;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD3;
  mediump float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD6.z > 0.0)
  ) * tmpvar_4.w) * tmpvar_7.w);
  mediump vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_10 * 4.0));
  c_11.xyz = tmpvar_15;
  c_11.w = (tmpvar_14 * (atten_10 * 4.0));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD3;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 27 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_LightTextureB0, vec2(tmpvar_6));
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD3;
  mediump float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD6.z > 0.0)
  ) * tmpvar_4.w) * tmpvar_7.w);
  mediump vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_10 * 4.0));
  c_11.xyz = tmpvar_15;
  c_11.w = (tmpvar_14 * (atten_10 * 4.0));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD3;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float4 xlv_TEXCOORD6;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float4 tmpvar_2;
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_3 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_3 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))).w * textureCube (_LightTexture0, xlv_TEXCOORD6).w);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhflpoahochcnnnhlfgknaokaoinoejfeabaaaaaahmaeaaaaadaaaaaa
cmaaaaaajmaaaaaagmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaa
agajbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  mediump vec3 lightDir_7;
  lightDir_7 = tmpvar_3;
  mediump vec3 normal_8;
  normal_8 = xlv_TEXCOORD3;
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
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD3;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * tmpvar_19.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  mediump vec3 lightDir_7;
  lightDir_7 = tmpvar_3;
  mediump vec3 normal_8;
  normal_8 = xlv_TEXCOORD3;
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
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD3;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * tmpvar_19.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 22 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_LightTexture0, xlv_TEXCOORD6);
  mediump vec3 lightDir_7;
  lightDir_7 = tmpvar_3;
  mediump vec3 normal_8;
  normal_8 = xlv_TEXCOORD3;
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
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD3;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * tmpvar_19.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float3 xlv_TEXCOORD6;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_3 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_3 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD6;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = texture2D (_LightTexture0, xlv_TEXCOORD6).w;
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedadjoefcbpmdfkbpmfbjifpilfndhcbpkabaaaaaahmaeaaaaadaaaaaa
cmaaaaaajmaaaaaagmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaadapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaa
agajbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD6);
  mediump vec3 lightDir_5;
  lightDir_5 = tmpvar_3;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD3;
  mediump float atten_7;
  atten_7 = tmpvar_4.w;
  mediump vec4 c_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(lightDir_5);
  lightDir_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(normal_6);
  normal_6 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_9);
  highp vec3 tmpvar_12;
  tmpvar_12 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_11) * (atten_7 * 4.0));
  c_8.xyz = tmpvar_12;
  c_8.w = (tmpvar_11 * (atten_7 * 4.0));
  lowp vec3 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_14;
  lightDir_14 = tmpvar_13;
  mediump vec3 normal_15;
  normal_15 = xlv_TEXCOORD3;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * tmpvar_17.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD6);
  mediump vec3 lightDir_5;
  lightDir_5 = tmpvar_3;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD3;
  mediump float atten_7;
  atten_7 = tmpvar_4.w;
  mediump vec4 c_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(lightDir_5);
  lightDir_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(normal_6);
  normal_6 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_9);
  highp vec3 tmpvar_12;
  tmpvar_12 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_11) * (atten_7 * 4.0));
  c_8.xyz = tmpvar_12;
  c_8.w = (tmpvar_11 * (atten_7 * 4.0));
  lowp vec3 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_14;
  lightDir_14 = tmpvar_13;
  mediump vec3 normal_15;
  normal_15 = xlv_TEXCOORD3;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * tmpvar_17.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_LightTexture0, xlv_TEXCOORD6);
  mediump vec3 lightDir_5;
  lightDir_5 = tmpvar_3;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD3;
  mediump float atten_7;
  atten_7 = tmpvar_4.w;
  mediump vec4 c_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(lightDir_5);
  lightDir_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(normal_6);
  normal_6 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_9);
  highp vec3 tmpvar_12;
  tmpvar_12 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_11) * (atten_7 * 4.0));
  c_8.xyz = tmpvar_12;
  c_8.w = (tmpvar_11 * (atten_7 * 4.0));
  lowp vec3 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_14;
  lightDir_14 = tmpvar_13;
  mediump vec3 normal_15;
  normal_15 = xlv_TEXCOORD3;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * tmpvar_17.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float2 xlv_TEXCOORD6;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float2 tmpvar_2;
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_3 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_3 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  float tmpvar_5;
  if ((tmpvar_4.x < (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))) {
    tmpvar_5 = _LightShadowData.x;
  } else {
    tmpvar_5 = 1.0;
  };
  float atten_6;
  atten_6 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_2.w) * tmpvar_3.w) * tmpvar_5);
  vec4 c_7;
  float tmpvar_8;
  tmpvar_8 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 4.0));
  c_7.w = (tmpvar_8 * (atten_6 * 4.0));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_10;
  tmpvar_10 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_9))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_9))
  , 0.0, 1.0)));
  color_1.w = tmpvar_10.w;
  color_1.xyz = (tmpvar_10.xyz * tmpvar_10.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  highp float tmpvar_11;
  if ((tmpvar_10.x < (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_9 = tmpvar_11;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float atten_14;
  atten_14 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_18) * (atten_14 * 4.0));
  c_15.xyz = tmpvar_19;
  c_15.w = (tmpvar_18 * (atten_14 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  highp float tmpvar_11;
  if ((tmpvar_10.x < (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_9 = tmpvar_11;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float atten_14;
  atten_14 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_18) * (atten_14 * 4.0));
  c_15.xyz = tmpvar_19;
  c_15.w = (tmpvar_18 * (atten_14 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 31 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
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
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz))).w) * (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x * 
    (1.0 - _LightShadowData.x)
  )));
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgllbmhbpckjlfecldfbddikbghnljanpabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 31 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DProjEXT (_ShadowMapTexture, xlv_TEXCOORD7);
  mediump float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_13;
  lightDir_13 = tmpvar_3;
  mediump vec3 normal_14;
  normal_14 = xlv_TEXCOORD3;
  mediump float atten_15;
  atten_15 = (((
    float((xlv_TEXCOORD6.z > 0.0))
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
  highp vec3 tmpvar_20;
  tmpvar_20 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_19) * (atten_15 * 4.0));
  c_16.xyz = tmpvar_20;
  c_16.w = (tmpvar_19 * (atten_15 * 4.0));
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_22;
  lightDir_22 = tmpvar_21;
  mediump vec3 normal_23;
  normal_23 = xlv_TEXCOORD3;
  mediump float tmpvar_24;
  tmpvar_24 = dot (normal_23, lightDir_22);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (c_16 * mix (1.0, clamp (
    floor((1.01 + tmpvar_24))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_24))
  , 0.0, 1.0)));
  color_2.w = tmpvar_25.w;
  color_2.xyz = (tmpvar_25.xyz * tmpvar_25.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 31 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = textureProj (_ShadowMapTexture, xlv_TEXCOORD7);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float atten_14;
  atten_14 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_18) * (atten_14 * 4.0));
  c_15.xyz = tmpvar_19;
  c_15.w = (tmpvar_18 * (atten_14 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float4 xlv_TEXCOORD6;
  float4 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float4 tmpvar_2;
  float4 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 20 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (tmpvar_2.x * 4.0));
  c_3.w = (tmpvar_4 * (tmpvar_2.x * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednhdkonffncdkjoockihahemhocakflijabaaaaaahmaeaaaaadaaaaaa
cmaaaaaajmaaaaaagmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaa
agajbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  mediump vec3 lightDir_10;
  lightDir_10 = tmpvar_3;
  mediump vec3 normal_11;
  normal_11 = xlv_TEXCOORD3;
  mediump float atten_12;
  atten_12 = tmpvar_4;
  mediump vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(lightDir_10);
  lightDir_10 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(normal_11);
  normal_11 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (tmpvar_15, tmpvar_14);
  highp vec3 tmpvar_17;
  tmpvar_17 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_16) * (atten_12 * 4.0));
  c_13.xyz = tmpvar_17;
  c_13.w = (tmpvar_16 * (atten_12 * 4.0));
  lowp vec3 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_19;
  lightDir_19 = tmpvar_18;
  mediump vec3 normal_20;
  normal_20 = xlv_TEXCOORD3;
  mediump float tmpvar_21;
  tmpvar_21 = dot (normal_20, lightDir_19);
  mediump vec4 tmpvar_22;
  tmpvar_22 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_21))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_21))
  , 0.0, 1.0)));
  color_2.w = tmpvar_22.w;
  color_2.xyz = (tmpvar_22.xyz * tmpvar_22.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  mediump vec3 lightDir_10;
  lightDir_10 = tmpvar_3;
  mediump vec3 normal_11;
  normal_11 = xlv_TEXCOORD3;
  mediump float atten_12;
  atten_12 = tmpvar_4;
  mediump vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(lightDir_10);
  lightDir_10 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(normal_11);
  normal_11 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (tmpvar_15, tmpvar_14);
  highp vec3 tmpvar_17;
  tmpvar_17 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_16) * (atten_12 * 4.0));
  c_13.xyz = tmpvar_17;
  c_13.w = (tmpvar_16 * (atten_12 * 4.0));
  lowp vec3 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_19;
  lightDir_19 = tmpvar_18;
  mediump vec3 normal_20;
  normal_20 = xlv_TEXCOORD3;
  mediump float tmpvar_21;
  tmpvar_21 = dot (normal_20, lightDir_19);
  mediump vec4 tmpvar_22;
  tmpvar_22 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_21))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_21))
  , 0.0, 1.0)));
  color_2.w = tmpvar_22.w;
  color_2.xyz = (tmpvar_22.xyz * tmpvar_22.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 21 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  float atten_2;
  atten_2 = (texture2D (_LightTexture0, xlv_TEXCOORD6).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x);
  vec4 c_3;
  float tmpvar_4;
  tmpvar_4 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_3.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_4) * (atten_2 * 4.0));
  c_3.w = (tmpvar_4 * (atten_2 * 4.0));
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddclnoemmiamimkokofhlokmcdalbondgabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaadapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD6);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD3;
  mediump float atten_13;
  atten_13 = (tmpvar_4.w * tmpvar_5);
  mediump vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(lightDir_11);
  lightDir_11 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(normal_12);
  normal_12 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (tmpvar_16, tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_17) * (atten_13 * 4.0));
  c_14.xyz = tmpvar_18;
  c_14.w = (tmpvar_17 * (atten_13 * 4.0));
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_20;
  lightDir_20 = tmpvar_19;
  mediump vec3 normal_21;
  normal_21 = xlv_TEXCOORD3;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * tmpvar_23.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD6);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD3;
  mediump float atten_13;
  atten_13 = (tmpvar_4.w * tmpvar_5);
  mediump vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(lightDir_11);
  lightDir_11 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(normal_12);
  normal_12 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (tmpvar_16, tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_17) * (atten_13 * 4.0));
  c_14.xyz = tmpvar_18;
  c_14.w = (tmpvar_17 * (atten_13 * 4.0));
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_20;
  lightDir_20 = tmpvar_19;
  mediump vec3 normal_21;
  normal_21 = xlv_TEXCOORD3;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * tmpvar_23.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 29 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
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
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)));
  float tmpvar_3;
  tmpvar_3 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  float tmpvar_4;
  tmpvar_4 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD7), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float tmpvar_5;
  if ((tmpvar_4 < tmpvar_3)) {
    tmpvar_5 = _LightShadowData.x;
  } else {
    tmpvar_5 = 1.0;
  };
  float atten_6;
  atten_6 = (tmpvar_2.w * tmpvar_5);
  vec4 c_7;
  float tmpvar_8;
  tmpvar_8 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 4.0));
  c_7.w = (tmpvar_8 * (atten_6 * 4.0));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_10;
  tmpvar_10 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_9))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_9))
  , 0.0, 1.0)));
  color_1.w = tmpvar_10.w;
  color_1.xyz = (tmpvar_10.xyz * tmpvar_10.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlngmfglpindfefmchebajgfkolplnkfaabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaahapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 29 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_ShadowMapTexture, xlv_TEXCOORD7);
  packDist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (packDist_7, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp float tmpvar_10;
  if ((tmpvar_9 < tmpvar_6)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD3;
  mediump float atten_13;
  atten_13 = (tmpvar_5.w * tmpvar_10);
  mediump vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(lightDir_11);
  lightDir_11 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(normal_12);
  normal_12 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (tmpvar_16, tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_17) * (atten_13 * 4.0));
  c_14.xyz = tmpvar_18;
  c_14.w = (tmpvar_17 * (atten_13 * 4.0));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_20;
  lightDir_20 = tmpvar_19;
  mediump vec3 normal_21;
  normal_21 = xlv_TEXCOORD3;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * tmpvar_23.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 29 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_ShadowMapTexture, xlv_TEXCOORD7);
  packDist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (packDist_7, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp float tmpvar_10;
  if ((tmpvar_9 < tmpvar_6)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD3;
  mediump float atten_13;
  atten_13 = (tmpvar_5.w * tmpvar_10);
  mediump vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(lightDir_11);
  lightDir_11 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(normal_12);
  normal_12 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (tmpvar_16, tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_17) * (atten_13 * 4.0));
  c_14.xyz = tmpvar_18;
  c_14.w = (tmpvar_17 * (atten_13 * 4.0));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_20;
  lightDir_20 = tmpvar_19;
  mediump vec3 normal_21;
  normal_21 = xlv_TEXCOORD3;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * tmpvar_23.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 29 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ShadowMapTexture, xlv_TEXCOORD7);
  packDist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (packDist_7, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp float tmpvar_10;
  if ((tmpvar_9 < tmpvar_6)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD3;
  mediump float atten_13;
  atten_13 = (tmpvar_5.w * tmpvar_10);
  mediump vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(lightDir_11);
  lightDir_11 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(normal_12);
  normal_12 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (tmpvar_16, tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_17) * (atten_13 * 4.0));
  c_14.xyz = tmpvar_18;
  c_14.w = (tmpvar_17 * (atten_13 * 4.0));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_20;
  lightDir_20 = tmpvar_19;
  mediump vec3 normal_21;
  normal_21 = xlv_TEXCOORD3;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * tmpvar_23.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  float3 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 30 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
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
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)));
  vec4 tmpvar_3;
  tmpvar_3 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  float tmpvar_4;
  tmpvar_4 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  float tmpvar_5;
  tmpvar_5 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD7), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float tmpvar_6;
  if ((tmpvar_5 < tmpvar_4)) {
    tmpvar_6 = _LightShadowData.x;
  } else {
    tmpvar_6 = 1.0;
  };
  float atten_7;
  atten_7 = ((tmpvar_2.w * tmpvar_3.w) * tmpvar_6);
  vec4 c_8;
  float tmpvar_9;
  tmpvar_9 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_8.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_7 * 4.0));
  c_8.w = (tmpvar_9 * (atten_7 * 4.0));
  float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_11;
  tmpvar_11 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_10))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_10))
  , 0.0, 1.0)));
  color_1.w = tmpvar_11.w;
  color_1.xyz = (tmpvar_11.xyz * tmpvar_11.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlngmfglpindfefmchebajgfkolplnkfaabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaahapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 30 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  highp float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD7);
  packDist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (packDist_8, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp float tmpvar_11;
  if ((tmpvar_10 < tmpvar_7)) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float atten_14;
  atten_14 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_11);
  mediump vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_18) * (atten_14 * 4.0));
  c_15.xyz = tmpvar_19;
  c_15.w = (tmpvar_18 * (atten_14 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 30 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  highp float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD7);
  packDist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (packDist_8, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp float tmpvar_11;
  if ((tmpvar_10 < tmpvar_7)) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float atten_14;
  atten_14 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_11);
  mediump vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_18) * (atten_14 * 4.0));
  c_15.xyz = tmpvar_19;
  c_15.w = (tmpvar_18 * (atten_14 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 30 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_LightTexture0, xlv_TEXCOORD6);
  highp float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ShadowMapTexture, xlv_TEXCOORD7);
  packDist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (packDist_8, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp float tmpvar_11;
  if ((tmpvar_10 < tmpvar_7)) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD3;
  mediump float atten_14;
  atten_14 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_11);
  mediump vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_18) * (atten_14 * 4.0));
  c_15.xyz = tmpvar_19;
  c_15.w = (tmpvar_18 * (atten_14 * 4.0));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_20;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  float3 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 39 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz)));
  vec4 shadowVals_4;
  vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD7.xyz / xlv_TEXCOORD7.w);
  shadowVals_4.x = texture2D (_ShadowMapTexture, (tmpvar_5.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_4.y = texture2D (_ShadowMapTexture, (tmpvar_5.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_4.z = texture2D (_ShadowMapTexture, (tmpvar_5.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_4.w = texture2D (_ShadowMapTexture, (tmpvar_5.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_6;
  tmpvar_6 = lessThan (shadowVals_4, tmpvar_5.zzzz);
  vec4 tmpvar_7;
  tmpvar_7 = _LightShadowData.xxxx;
  float tmpvar_8;
  if (tmpvar_6.x) {
    tmpvar_8 = tmpvar_7.x;
  } else {
    tmpvar_8 = 1.0;
  };
  float tmpvar_9;
  if (tmpvar_6.y) {
    tmpvar_9 = tmpvar_7.y;
  } else {
    tmpvar_9 = 1.0;
  };
  float tmpvar_10;
  if (tmpvar_6.z) {
    tmpvar_10 = tmpvar_7.z;
  } else {
    tmpvar_10 = 1.0;
  };
  float tmpvar_11;
  if (tmpvar_6.w) {
    tmpvar_11 = tmpvar_7.w;
  } else {
    tmpvar_11 = 1.0;
  };
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8;
  tmpvar_12.y = tmpvar_9;
  tmpvar_12.z = tmpvar_10;
  tmpvar_12.w = tmpvar_11;
  float atten_13;
  atten_13 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_2.w) * tmpvar_3.w) * dot (tmpvar_12, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_14;
  float tmpvar_15;
  tmpvar_15 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_14.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_15) * (atten_13 * 4.0));
  c_14.w = (tmpvar_15 * (atten_13 * 4.0));
  float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_17;
  tmpvar_17 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_1.w = tmpvar_17.w;
  color_1.xyz = (tmpvar_17.xyz * tmpvar_17.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
// Stats: 39 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  highp vec4 shadowVals_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD7.xyz / xlv_TEXCOORD7.w);
  highp vec2 P_11;
  P_11 = (tmpvar_10.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, P_11).x;
  shadowVals_9.x = tmpvar_12;
  highp vec2 P_13;
  P_13 = (tmpvar_10.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, P_13).x;
  shadowVals_9.y = tmpvar_14;
  highp vec2 P_15;
  P_15 = (tmpvar_10.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, P_15).x;
  shadowVals_9.z = tmpvar_16;
  highp vec2 P_17;
  P_17 = (tmpvar_10.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, P_17).x;
  shadowVals_9.w = tmpvar_18;
  bvec4 tmpvar_19;
  tmpvar_19 = lessThan (shadowVals_9, tmpvar_10.zzzz);
  highp vec4 tmpvar_20;
  tmpvar_20 = _LightShadowData.xxxx;
  highp float tmpvar_21;
  if (tmpvar_19.x) {
    tmpvar_21 = tmpvar_20.x;
  } else {
    tmpvar_21 = 1.0;
  };
  highp float tmpvar_22;
  if (tmpvar_19.y) {
    tmpvar_22 = tmpvar_20.y;
  } else {
    tmpvar_22 = 1.0;
  };
  highp float tmpvar_23;
  if (tmpvar_19.z) {
    tmpvar_23 = tmpvar_20.z;
  } else {
    tmpvar_23 = 1.0;
  };
  highp float tmpvar_24;
  if (tmpvar_19.w) {
    tmpvar_24 = tmpvar_20.w;
  } else {
    tmpvar_24 = 1.0;
  };
  mediump vec4 tmpvar_25;
  tmpvar_25.x = tmpvar_21;
  tmpvar_25.y = tmpvar_22;
  tmpvar_25.z = tmpvar_23;
  tmpvar_25.w = tmpvar_24;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_25, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_26;
  mediump vec3 lightDir_27;
  lightDir_27 = tmpvar_3;
  mediump vec3 normal_28;
  normal_28 = xlv_TEXCOORD3;
  mediump float atten_29;
  atten_29 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(lightDir_27);
  lightDir_27 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = normalize(normal_28);
  normal_28 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (tmpvar_32, tmpvar_31);
  highp vec3 tmpvar_34;
  tmpvar_34 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_33) * (atten_29 * 4.0));
  c_30.xyz = tmpvar_34;
  c_30.w = (tmpvar_33 * (atten_29 * 4.0));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_36;
  lightDir_36 = tmpvar_35;
  mediump vec3 normal_37;
  normal_37 = xlv_TEXCOORD3;
  mediump float tmpvar_38;
  tmpvar_38 = dot (normal_37, lightDir_36);
  mediump vec4 tmpvar_39;
  tmpvar_39 = (c_30 * mix (1.0, clamp (
    floor((1.01 + tmpvar_38))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_38))
  , 0.0, 1.0)));
  color_2.w = tmpvar_39.w;
  color_2.xyz = (tmpvar_39.xyz * tmpvar_39.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 39 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  highp vec4 shadowVals_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD7.xyz / xlv_TEXCOORD7.w);
  highp vec2 P_11;
  P_11 = (tmpvar_10.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, P_11).x;
  shadowVals_9.x = tmpvar_12;
  highp vec2 P_13;
  P_13 = (tmpvar_10.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, P_13).x;
  shadowVals_9.y = tmpvar_14;
  highp vec2 P_15;
  P_15 = (tmpvar_10.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, P_15).x;
  shadowVals_9.z = tmpvar_16;
  highp vec2 P_17;
  P_17 = (tmpvar_10.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, P_17).x;
  shadowVals_9.w = tmpvar_18;
  bvec4 tmpvar_19;
  tmpvar_19 = lessThan (shadowVals_9, tmpvar_10.zzzz);
  highp vec4 tmpvar_20;
  tmpvar_20 = _LightShadowData.xxxx;
  highp float tmpvar_21;
  if (tmpvar_19.x) {
    tmpvar_21 = tmpvar_20.x;
  } else {
    tmpvar_21 = 1.0;
  };
  highp float tmpvar_22;
  if (tmpvar_19.y) {
    tmpvar_22 = tmpvar_20.y;
  } else {
    tmpvar_22 = 1.0;
  };
  highp float tmpvar_23;
  if (tmpvar_19.z) {
    tmpvar_23 = tmpvar_20.z;
  } else {
    tmpvar_23 = 1.0;
  };
  highp float tmpvar_24;
  if (tmpvar_19.w) {
    tmpvar_24 = tmpvar_20.w;
  } else {
    tmpvar_24 = 1.0;
  };
  mediump vec4 tmpvar_25;
  tmpvar_25.x = tmpvar_21;
  tmpvar_25.y = tmpvar_22;
  tmpvar_25.z = tmpvar_23;
  tmpvar_25.w = tmpvar_24;
  mediump float tmpvar_26;
  tmpvar_26 = dot (tmpvar_25, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_26;
  mediump vec3 lightDir_27;
  lightDir_27 = tmpvar_3;
  mediump vec3 normal_28;
  normal_28 = xlv_TEXCOORD3;
  mediump float atten_29;
  atten_29 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * tmpvar_4.w) * tmpvar_7.w) * tmpvar_8);
  mediump vec4 c_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(lightDir_27);
  lightDir_27 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = normalize(normal_28);
  normal_28 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (tmpvar_32, tmpvar_31);
  highp vec3 tmpvar_34;
  tmpvar_34 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_33) * (atten_29 * 4.0));
  c_30.xyz = tmpvar_34;
  c_30.w = (tmpvar_33 * (atten_29 * 4.0));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_36;
  lightDir_36 = tmpvar_35;
  mediump vec3 normal_37;
  normal_37 = xlv_TEXCOORD3;
  mediump float tmpvar_38;
  tmpvar_38 = dot (normal_37, lightDir_36);
  mediump vec4 tmpvar_39;
  tmpvar_39 = (c_30 * mix (1.0, clamp (
    floor((1.01 + tmpvar_38))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_38))
  , 0.0, 1.0)));
  color_2.w = tmpvar_39.w;
  color_2.xyz = (tmpvar_39.xyz * tmpvar_39.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 37 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
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
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  vec4 shadows_2;
  vec3 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD7.xyz / xlv_TEXCOORD7.w);
  shadows_2.x = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[0].xyz)).x;
  shadows_2.y = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[1].xyz)).x;
  shadows_2.z = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[2].xyz)).x;
  shadows_2.w = shadow2D (_ShadowMapTexture, (tmpvar_3 + _ShadowOffsets[3].xyz)).x;
  vec4 tmpvar_4;
  tmpvar_4 = (_LightShadowData.xxxx + (shadows_2 * (1.0 - _LightShadowData.xxxx)));
  shadows_2 = tmpvar_4;
  float atten_5;
  atten_5 = (((
    float((xlv_TEXCOORD6.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz))).w) * dot (tmpvar_4, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_6;
  float tmpvar_7;
  tmpvar_7 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_6.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_7) * (atten_5 * 4.0));
  c_6.w = (tmpvar_7 * (atten_5 * 4.0));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_9;
  tmpvar_9 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_8))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_8))
  , 0.0, 1.0)));
  color_1.w = tmpvar_9.w;
  color_1.xyz = (tmpvar_9.xyz * tmpvar_9.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgllbmhbpckjlfecldfbddikbghnljanpabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 37 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump vec4 shadows_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD7.xyz / xlv_TEXCOORD7.w);
  highp vec3 coord_11;
  coord_11 = (tmpvar_10 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_12;
  tmpvar_12 = shadow2DEXT (_ShadowMapTexture, coord_11);
  shadows_9.x = tmpvar_12;
  highp vec3 coord_13;
  coord_13 = (tmpvar_10 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_14;
  tmpvar_14 = shadow2DEXT (_ShadowMapTexture, coord_13);
  shadows_9.y = tmpvar_14;
  highp vec3 coord_15;
  coord_15 = (tmpvar_10 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_16;
  tmpvar_16 = shadow2DEXT (_ShadowMapTexture, coord_15);
  shadows_9.z = tmpvar_16;
  highp vec3 coord_17;
  coord_17 = (tmpvar_10 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, coord_17);
  shadows_9.w = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (_LightShadowData.xxxx + (shadows_9 * (1.0 - _LightShadowData.xxxx)));
  shadows_9 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = dot (shadows_9, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_3;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float atten_23;
  atten_23 = (((
    float((xlv_TEXCOORD6.z > 0.0))
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
  highp vec3 tmpvar_28;
  tmpvar_28 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_27) * (atten_23 * 4.0));
  c_24.xyz = tmpvar_28;
  c_24.w = (tmpvar_27 * (atten_23 * 4.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_29;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD3;
  mediump float tmpvar_32;
  tmpvar_32 = dot (normal_31, lightDir_30);
  mediump vec4 tmpvar_33;
  tmpvar_33 = (c_24 * mix (1.0, clamp (
    floor((1.01 + tmpvar_32))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_32))
  , 0.0, 1.0)));
  color_2.w = tmpvar_33.w;
  color_2.xyz = (tmpvar_33.xyz * tmpvar_33.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 37 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = texture (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump vec4 shadows_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD7.xyz / xlv_TEXCOORD7.w);
  highp vec3 coord_11;
  coord_11 = (tmpvar_10 + _ShadowOffsets[0].xyz);
  mediump float tmpvar_12;
  tmpvar_12 = texture (_ShadowMapTexture, coord_11);
  shadows_9.x = tmpvar_12;
  highp vec3 coord_13;
  coord_13 = (tmpvar_10 + _ShadowOffsets[1].xyz);
  mediump float tmpvar_14;
  tmpvar_14 = texture (_ShadowMapTexture, coord_13);
  shadows_9.y = tmpvar_14;
  highp vec3 coord_15;
  coord_15 = (tmpvar_10 + _ShadowOffsets[2].xyz);
  mediump float tmpvar_16;
  tmpvar_16 = texture (_ShadowMapTexture, coord_15);
  shadows_9.z = tmpvar_16;
  highp vec3 coord_17;
  coord_17 = (tmpvar_10 + _ShadowOffsets[3].xyz);
  mediump float tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, coord_17);
  shadows_9.w = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (_LightShadowData.xxxx + (shadows_9 * (1.0 - _LightShadowData.xxxx)));
  shadows_9 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = dot (shadows_9, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = tmpvar_3;
  mediump vec3 normal_22;
  normal_22 = xlv_TEXCOORD3;
  mediump float atten_23;
  atten_23 = (((
    float((xlv_TEXCOORD6.z > 0.0))
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
  highp vec3 tmpvar_28;
  tmpvar_28 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_27) * (atten_23 * 4.0));
  c_24.xyz = tmpvar_28;
  c_24.w = (tmpvar_27 * (atten_23 * 4.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_29;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD3;
  mediump float tmpvar_32;
  tmpvar_32 = dot (normal_31, lightDir_30);
  mediump vec4 tmpvar_33;
  tmpvar_33 = (c_24 * mix (1.0, clamp (
    floor((1.01 + tmpvar_32))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_32))
  , 0.0, 1.0)));
  color_2.w = tmpvar_33.w;
  color_2.xyz = (tmpvar_33.xyz * tmpvar_33.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float4 xlv_TEXCOORD6;
  float4 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float4 tmpvar_2;
  float4 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 40 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
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
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)));
  vec4 shadowVals_3;
  shadowVals_3.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_3.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_3.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_3.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_4;
  tmpvar_4 = lessThan (shadowVals_3, vec4(((
    sqrt(dot (xlv_TEXCOORD7, xlv_TEXCOORD7))
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
  tmpvar_13 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_12.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_11 * 4.0));
  c_12.w = (tmpvar_13 * (atten_11 * 4.0));
  float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_15;
  tmpvar_15 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_1.w = tmpvar_15.w;
  color_1.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlngmfglpindfefmchebajgfkolplnkfaabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaahapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 40 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  highp vec4 shadowVals_7;
  highp float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, vec_9);
  packDist_10 = tmpvar_11;
  shadowVals_7.x = dot (packDist_10, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_12;
  vec_12 = (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureCube (_ShadowMapTexture, vec_12);
  packDist_13 = tmpvar_14;
  shadowVals_7.y = dot (packDist_13, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_15;
  vec_15 = (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureCube (_ShadowMapTexture, vec_15);
  packDist_16 = tmpvar_17;
  shadowVals_7.z = dot (packDist_16, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = textureCube (_ShadowMapTexture, vec_18);
  packDist_19 = tmpvar_20;
  shadowVals_7.w = dot (packDist_19, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_21;
  tmpvar_21 = lessThan (shadowVals_7, vec4(tmpvar_8));
  highp vec4 tmpvar_22;
  tmpvar_22 = _LightShadowData.xxxx;
  highp float tmpvar_23;
  if (tmpvar_21.x) {
    tmpvar_23 = tmpvar_22.x;
  } else {
    tmpvar_23 = 1.0;
  };
  highp float tmpvar_24;
  if (tmpvar_21.y) {
    tmpvar_24 = tmpvar_22.y;
  } else {
    tmpvar_24 = 1.0;
  };
  highp float tmpvar_25;
  if (tmpvar_21.z) {
    tmpvar_25 = tmpvar_22.z;
  } else {
    tmpvar_25 = 1.0;
  };
  highp float tmpvar_26;
  if (tmpvar_21.w) {
    tmpvar_26 = tmpvar_22.w;
  } else {
    tmpvar_26 = 1.0;
  };
  mediump vec4 tmpvar_27;
  tmpvar_27.x = tmpvar_23;
  tmpvar_27.y = tmpvar_24;
  tmpvar_27.z = tmpvar_25;
  tmpvar_27.w = tmpvar_26;
  mediump float tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_6 = tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = tmpvar_3;
  mediump vec3 normal_30;
  normal_30 = xlv_TEXCOORD3;
  mediump float atten_31;
  atten_31 = (tmpvar_5.w * tmpvar_6);
  mediump vec4 c_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_29);
  lightDir_29 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(normal_30);
  normal_30 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (tmpvar_34, tmpvar_33);
  highp vec3 tmpvar_36;
  tmpvar_36 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_35) * (atten_31 * 4.0));
  c_32.xyz = tmpvar_36;
  c_32.w = (tmpvar_35 * (atten_31 * 4.0));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_38;
  lightDir_38 = tmpvar_37;
  mediump vec3 normal_39;
  normal_39 = xlv_TEXCOORD3;
  mediump float tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (c_32 * mix (1.0, clamp (
    floor((1.01 + tmpvar_40))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_40))
  , 0.0, 1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * tmpvar_41.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 40 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  highp vec4 shadowVals_7;
  highp float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, vec_9);
  packDist_10 = tmpvar_11;
  shadowVals_7.x = dot (packDist_10, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_12;
  vec_12 = (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureCube (_ShadowMapTexture, vec_12);
  packDist_13 = tmpvar_14;
  shadowVals_7.y = dot (packDist_13, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_15;
  vec_15 = (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureCube (_ShadowMapTexture, vec_15);
  packDist_16 = tmpvar_17;
  shadowVals_7.z = dot (packDist_16, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = textureCube (_ShadowMapTexture, vec_18);
  packDist_19 = tmpvar_20;
  shadowVals_7.w = dot (packDist_19, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_21;
  tmpvar_21 = lessThan (shadowVals_7, vec4(tmpvar_8));
  highp vec4 tmpvar_22;
  tmpvar_22 = _LightShadowData.xxxx;
  highp float tmpvar_23;
  if (tmpvar_21.x) {
    tmpvar_23 = tmpvar_22.x;
  } else {
    tmpvar_23 = 1.0;
  };
  highp float tmpvar_24;
  if (tmpvar_21.y) {
    tmpvar_24 = tmpvar_22.y;
  } else {
    tmpvar_24 = 1.0;
  };
  highp float tmpvar_25;
  if (tmpvar_21.z) {
    tmpvar_25 = tmpvar_22.z;
  } else {
    tmpvar_25 = 1.0;
  };
  highp float tmpvar_26;
  if (tmpvar_21.w) {
    tmpvar_26 = tmpvar_22.w;
  } else {
    tmpvar_26 = 1.0;
  };
  mediump vec4 tmpvar_27;
  tmpvar_27.x = tmpvar_23;
  tmpvar_27.y = tmpvar_24;
  tmpvar_27.z = tmpvar_25;
  tmpvar_27.w = tmpvar_26;
  mediump float tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_6 = tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = tmpvar_3;
  mediump vec3 normal_30;
  normal_30 = xlv_TEXCOORD3;
  mediump float atten_31;
  atten_31 = (tmpvar_5.w * tmpvar_6);
  mediump vec4 c_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_29);
  lightDir_29 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(normal_30);
  normal_30 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (tmpvar_34, tmpvar_33);
  highp vec3 tmpvar_36;
  tmpvar_36 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_35) * (atten_31 * 4.0));
  c_32.xyz = tmpvar_36;
  c_32.w = (tmpvar_35 * (atten_31 * 4.0));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_38;
  lightDir_38 = tmpvar_37;
  mediump vec3 normal_39;
  normal_39 = xlv_TEXCOORD3;
  mediump float tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (c_32 * mix (1.0, clamp (
    floor((1.01 + tmpvar_40))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_40))
  , 0.0, 1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * tmpvar_41.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 40 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  highp vec4 shadowVals_7;
  highp float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, vec_9);
  packDist_10 = tmpvar_11;
  shadowVals_7.x = dot (packDist_10, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_12;
  vec_12 = (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_ShadowMapTexture, vec_12);
  packDist_13 = tmpvar_14;
  shadowVals_7.y = dot (packDist_13, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_15;
  vec_15 = (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture (_ShadowMapTexture, vec_15);
  packDist_16 = tmpvar_17;
  shadowVals_7.z = dot (packDist_16, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture (_ShadowMapTexture, vec_18);
  packDist_19 = tmpvar_20;
  shadowVals_7.w = dot (packDist_19, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_21;
  tmpvar_21 = lessThan (shadowVals_7, vec4(tmpvar_8));
  highp vec4 tmpvar_22;
  tmpvar_22 = _LightShadowData.xxxx;
  highp float tmpvar_23;
  if (tmpvar_21.x) {
    tmpvar_23 = tmpvar_22.x;
  } else {
    tmpvar_23 = 1.0;
  };
  highp float tmpvar_24;
  if (tmpvar_21.y) {
    tmpvar_24 = tmpvar_22.y;
  } else {
    tmpvar_24 = 1.0;
  };
  highp float tmpvar_25;
  if (tmpvar_21.z) {
    tmpvar_25 = tmpvar_22.z;
  } else {
    tmpvar_25 = 1.0;
  };
  highp float tmpvar_26;
  if (tmpvar_21.w) {
    tmpvar_26 = tmpvar_22.w;
  } else {
    tmpvar_26 = 1.0;
  };
  mediump vec4 tmpvar_27;
  tmpvar_27.x = tmpvar_23;
  tmpvar_27.y = tmpvar_24;
  tmpvar_27.z = tmpvar_25;
  tmpvar_27.w = tmpvar_26;
  mediump float tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_6 = tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = tmpvar_3;
  mediump vec3 normal_30;
  normal_30 = xlv_TEXCOORD3;
  mediump float atten_31;
  atten_31 = (tmpvar_5.w * tmpvar_6);
  mediump vec4 c_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_29);
  lightDir_29 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(normal_30);
  normal_30 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (tmpvar_34, tmpvar_33);
  highp vec3 tmpvar_36;
  tmpvar_36 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_35) * (atten_31 * 4.0));
  c_32.xyz = tmpvar_36;
  c_32.w = (tmpvar_35 * (atten_31 * 4.0));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_38;
  lightDir_38 = tmpvar_37;
  mediump vec3 normal_39;
  normal_39 = xlv_TEXCOORD3;
  mediump float tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (c_32 * mix (1.0, clamp (
    floor((1.01 + tmpvar_40))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_40))
  , 0.0, 1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * tmpvar_41.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  float3 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 41 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
varying float xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(gl_Vertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
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
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)));
  vec4 tmpvar_3;
  tmpvar_3 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  vec4 shadowVals_4;
  shadowVals_4.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_4.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_4.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_4.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_5;
  tmpvar_5 = lessThan (shadowVals_4, vec4(((
    sqrt(dot (xlv_TEXCOORD7, xlv_TEXCOORD7))
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
  tmpvar_14 = dot (normalize(xlv_TEXCOORD3), normalize(_WorldSpaceLightPos0.xyz));
  c_13.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_12 * 4.0));
  c_13.w = (tmpvar_14 * (atten_12 * 4.0));
  float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_16;
  tmpvar_16 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_15))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_15))
  , 0.0, 1.0)));
  color_1.w = tmpvar_16.w;
  color_1.xyz = (tmpvar_16.xyz * tmpvar_16.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 23 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r0.xyz, r1, -r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
add r1.xyz, -r1, c8
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp4 r0.y, v0, v0
rsq r0.y, r0.y
mul o2.xyz, r0.x, -r1
mul r1.xyz, r0.y, v0
rcp o1.x, r0.x
mov o3.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedlngmfglpindfefmchebajgfkolplnkfaabaaaaaajeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaafaaaaaaahapaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaad
occabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaafbccabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaahoccabaaaabaaaaaapgapbaaaabaaaaaaagajbaaaabaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 41 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  highp float tmpvar_7;
  highp vec4 shadowVals_8;
  highp float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_ShadowMapTexture, vec_10);
  packDist_11 = tmpvar_12;
  shadowVals_8.x = dot (packDist_11, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_13;
  vec_13 = (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_ShadowMapTexture, vec_13);
  packDist_14 = tmpvar_15;
  shadowVals_8.y = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_16;
  vec_16 = (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_ShadowMapTexture, vec_16);
  packDist_17 = tmpvar_18;
  shadowVals_8.z = dot (packDist_17, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_19;
  vec_19 = (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_ShadowMapTexture, vec_19);
  packDist_20 = tmpvar_21;
  shadowVals_8.w = dot (packDist_20, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_22;
  tmpvar_22 = lessThan (shadowVals_8, vec4(tmpvar_9));
  highp vec4 tmpvar_23;
  tmpvar_23 = _LightShadowData.xxxx;
  highp float tmpvar_24;
  if (tmpvar_22.x) {
    tmpvar_24 = tmpvar_23.x;
  } else {
    tmpvar_24 = 1.0;
  };
  highp float tmpvar_25;
  if (tmpvar_22.y) {
    tmpvar_25 = tmpvar_23.y;
  } else {
    tmpvar_25 = 1.0;
  };
  highp float tmpvar_26;
  if (tmpvar_22.z) {
    tmpvar_26 = tmpvar_23.z;
  } else {
    tmpvar_26 = 1.0;
  };
  highp float tmpvar_27;
  if (tmpvar_22.w) {
    tmpvar_27 = tmpvar_23.w;
  } else {
    tmpvar_27 = 1.0;
  };
  mediump vec4 tmpvar_28;
  tmpvar_28.x = tmpvar_24;
  tmpvar_28.y = tmpvar_25;
  tmpvar_28.z = tmpvar_26;
  tmpvar_28.w = tmpvar_27;
  mediump float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_7 = tmpvar_29;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_3;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD3;
  mediump float atten_32;
  atten_32 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_7);
  mediump vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(lightDir_30);
  lightDir_30 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = normalize(normal_31);
  normal_31 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = dot (tmpvar_35, tmpvar_34);
  highp vec3 tmpvar_37;
  tmpvar_37 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_36) * (atten_32 * 4.0));
  c_33.xyz = tmpvar_37;
  c_33.w = (tmpvar_36 * (atten_32 * 4.0));
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_39;
  lightDir_39 = tmpvar_38;
  mediump vec3 normal_40;
  normal_40 = xlv_TEXCOORD3;
  mediump float tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (c_33 * mix (1.0, clamp (
    floor((1.01 + tmpvar_41))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_41))
  , 0.0, 1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * tmpvar_42.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 41 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureCube (_LightTexture0, xlv_TEXCOORD6);
  highp float tmpvar_7;
  highp vec4 shadowVals_8;
  highp float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_ShadowMapTexture, vec_10);
  packDist_11 = tmpvar_12;
  shadowVals_8.x = dot (packDist_11, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_13;
  vec_13 = (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_ShadowMapTexture, vec_13);
  packDist_14 = tmpvar_15;
  shadowVals_8.y = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_16;
  vec_16 = (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_ShadowMapTexture, vec_16);
  packDist_17 = tmpvar_18;
  shadowVals_8.z = dot (packDist_17, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_19;
  vec_19 = (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_ShadowMapTexture, vec_19);
  packDist_20 = tmpvar_21;
  shadowVals_8.w = dot (packDist_20, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_22;
  tmpvar_22 = lessThan (shadowVals_8, vec4(tmpvar_9));
  highp vec4 tmpvar_23;
  tmpvar_23 = _LightShadowData.xxxx;
  highp float tmpvar_24;
  if (tmpvar_22.x) {
    tmpvar_24 = tmpvar_23.x;
  } else {
    tmpvar_24 = 1.0;
  };
  highp float tmpvar_25;
  if (tmpvar_22.y) {
    tmpvar_25 = tmpvar_23.y;
  } else {
    tmpvar_25 = 1.0;
  };
  highp float tmpvar_26;
  if (tmpvar_22.z) {
    tmpvar_26 = tmpvar_23.z;
  } else {
    tmpvar_26 = 1.0;
  };
  highp float tmpvar_27;
  if (tmpvar_22.w) {
    tmpvar_27 = tmpvar_23.w;
  } else {
    tmpvar_27 = 1.0;
  };
  mediump vec4 tmpvar_28;
  tmpvar_28.x = tmpvar_24;
  tmpvar_28.y = tmpvar_25;
  tmpvar_28.z = tmpvar_26;
  tmpvar_28.w = tmpvar_27;
  mediump float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_7 = tmpvar_29;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_3;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD3;
  mediump float atten_32;
  atten_32 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_7);
  mediump vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(lightDir_30);
  lightDir_30 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = normalize(normal_31);
  normal_31 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = dot (tmpvar_35, tmpvar_34);
  highp vec3 tmpvar_37;
  tmpvar_37 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_36) * (atten_32 * 4.0));
  c_33.xyz = tmpvar_37;
  c_33.w = (tmpvar_36 * (atten_32 * 4.0));
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_39;
  lightDir_39 = tmpvar_38;
  mediump vec3 normal_40;
  normal_40 = xlv_TEXCOORD3;
  mediump float tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (c_33 * mix (1.0, clamp (
    floor((1.01 + tmpvar_41))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_41))
  , 0.0, 1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * tmpvar_42.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 41 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _LightShadowData;
uniform lowp samplerCube _ShadowMapTexture;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD6, xlv_TEXCOORD6);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_LightTexture0, xlv_TEXCOORD6);
  highp float tmpvar_7;
  highp vec4 shadowVals_8;
  highp float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD7, xlv_TEXCOORD7)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD7 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_ShadowMapTexture, vec_10);
  packDist_11 = tmpvar_12;
  shadowVals_8.x = dot (packDist_11, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_13;
  vec_13 = (xlv_TEXCOORD7 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture (_ShadowMapTexture, vec_13);
  packDist_14 = tmpvar_15;
  shadowVals_8.y = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_16;
  vec_16 = (xlv_TEXCOORD7 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, vec_16);
  packDist_17 = tmpvar_18;
  shadowVals_8.z = dot (packDist_17, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_19;
  vec_19 = (xlv_TEXCOORD7 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture (_ShadowMapTexture, vec_19);
  packDist_20 = tmpvar_21;
  shadowVals_8.w = dot (packDist_20, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bvec4 tmpvar_22;
  tmpvar_22 = lessThan (shadowVals_8, vec4(tmpvar_9));
  highp vec4 tmpvar_23;
  tmpvar_23 = _LightShadowData.xxxx;
  highp float tmpvar_24;
  if (tmpvar_22.x) {
    tmpvar_24 = tmpvar_23.x;
  } else {
    tmpvar_24 = 1.0;
  };
  highp float tmpvar_25;
  if (tmpvar_22.y) {
    tmpvar_25 = tmpvar_23.y;
  } else {
    tmpvar_25 = 1.0;
  };
  highp float tmpvar_26;
  if (tmpvar_22.z) {
    tmpvar_26 = tmpvar_23.z;
  } else {
    tmpvar_26 = 1.0;
  };
  highp float tmpvar_27;
  if (tmpvar_22.w) {
    tmpvar_27 = tmpvar_23.w;
  } else {
    tmpvar_27 = 1.0;
  };
  mediump vec4 tmpvar_28;
  tmpvar_28.x = tmpvar_24;
  tmpvar_28.y = tmpvar_25;
  tmpvar_28.z = tmpvar_26;
  tmpvar_28.w = tmpvar_27;
  mediump float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_7 = tmpvar_29;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_3;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD3;
  mediump float atten_32;
  atten_32 = ((tmpvar_5.w * tmpvar_6.w) * tmpvar_7);
  mediump vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(lightDir_30);
  lightDir_30 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = normalize(normal_31);
  normal_31 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = dot (tmpvar_35, tmpvar_34);
  highp vec3 tmpvar_37;
  tmpvar_37 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_36) * (atten_32 * 4.0));
  c_33.xyz = tmpvar_37;
  c_33.w = (tmpvar_36 * (atten_32 * 4.0));
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_39;
  lightDir_39 = tmpvar_38;
  mediump vec3 normal_40;
  normal_40 = xlv_TEXCOORD3;
  mediump float tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (c_33 * mix (1.0, clamp (
    floor((1.01 + tmpvar_41))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_41))
  , 0.0, 1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * tmpvar_42.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float3 tmpvar_2;
  float3 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 23 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  mediump vec3 lightDir_7;
  lightDir_7 = tmpvar_3;
  mediump vec3 normal_8;
  normal_8 = xlv_TEXCOORD3;
  mediump float atten_9;
  atten_9 = shadow_4;
  mediump vec4 c_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(lightDir_7);
  lightDir_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(normal_8);
  normal_8 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  lowp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD3;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * tmpvar_19.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 23 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD1 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_3 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD3;
  mediump float atten_10;
  atten_10 = shadow_4;
  mediump vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_10 * 4.0));
  c_11.xyz = tmpvar_15;
  c_11.w = (tmpvar_14 * (atten_10 * 4.0));
  lowp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD3;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float4 xlv_TEXCOORD6;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float4 tmpvar_2;
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_4, tmpvar_4));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_3 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_3 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 24 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp float xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD6);
  lowp float shadow_5;
  lowp float tmpvar_6;
  tmpvar_6 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_7;
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD3;
  mediump float atten_10;
  atten_10 = (tmpvar_4.w * shadow_5);
  mediump vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_14) * (atten_10 * 4.0));
  c_11.xyz = tmpvar_15;
  c_11.w = (tmpvar_14 * (atten_10 * 4.0));
  lowp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_17;
  lightDir_17 = tmpvar_16;
  mediump vec3 normal_18;
  normal_18 = xlv_TEXCOORD3;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 24 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  xlv_TEXCOORD1 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = -(normalize(_glesVertex)).xyz;
  xlv_TEXCOORD3 = normalize((tmpvar_4 - (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz));
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_TEXCOORD7 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_LightTexture0, xlv_TEXCOORD6);
  lowp float shadow_5;
  mediump float tmpvar_6;
  tmpvar_6 = texture (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  lowp float tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_8;
  mediump vec3 lightDir_9;
  lightDir_9 = tmpvar_3;
  mediump vec3 normal_10;
  normal_10 = xlv_TEXCOORD3;
  mediump float atten_11;
  atten_11 = (tmpvar_4.w * shadow_5);
  mediump vec4 c_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(lightDir_9);
  lightDir_9 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(normal_10);
  normal_10 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_15) * (atten_11 * 4.0));
  c_12.xyz = tmpvar_16;
  c_12.w = (tmpvar_15 * (atten_11 * 4.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_18;
  lightDir_18 = tmpvar_17;
  mediump vec3 normal_19;
  normal_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = dot (normal_19, lightDir_18);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_20))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_20))
  , 0.0, 1.0)));
  color_2.w = tmpvar_21.w;
  color_2.xyz = (tmpvar_21.xyz * tmpvar_21.w);
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 144
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
  float2 xlv_TEXCOORD6;
  float4 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  float2 tmpvar_2;
  float4 tmpvar_3;
  float3 tmpvar_4;
  tmpvar_4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _mtl_u._WorldSpaceCameraPos);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = sqrt(dot (tmpvar_5, tmpvar_5));
  _mtl_o.xlv_TEXCOORD1 = normalize((tmpvar_4 - _mtl_u._WorldSpaceCameraPos));
  _mtl_o.xlv_TEXCOORD2 = -(normalize(_mtl_i._glesVertex)).xyz;
  _mtl_o.xlv_TEXCOORD3 = normalize((tmpvar_4 - (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz));
  _mtl_o.xlv_TEXCOORD5 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD7 = tmpvar_3;
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
// Stats: 28 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
"ps_3_0
dcl_2d s0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xyz
dp3_pp r0.x, c0, c0
rsq_pp r0.w, r0.x
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, v1, v1
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
dp3_pp r0.y, r0, r1
dp4 r0.w, c0, c0
rsq r0.z, r0.w
mul r1.xyz, r0.z, c0
dp3_pp r0.z, v1, r1
add_pp r1.w, r0.z, c3.z
dp3 r0.x, v2, v2
texld r0.x, r0.x, s0
mul_pp r0.w, r0.x, r0.y
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
mul_pp r1.xyz, r0.y, r1
add_pp_sat r1.w, r1, -r2.x
mul_pp_sat r0.y, -r0.z, c3
add_pp r1.w, r1, c3
mad_pp r1.w, r0.y, r1, c4.x
mul_pp r0.x, r0, c3
mul_pp r0.w, r0, c3.x
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 24 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedcjjijoanolnpfijnmhbhhghafpfdcfpdabaaaaaaimaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaanfaaaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpbaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiaeadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD6;
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD6, _mtl_i.xlv_TEXCOORD6);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  half3 lightDir_6;
  lightDir_6 = half3(tmpvar_3);
  half3 normal_7;
  normal_7 = half3(_mtl_i.xlv_TEXCOORD3);
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
  float3 tmpvar_13;
  tmpvar_13 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_12) * (atten_8 * (half)4.0)));
  c_9.xyz = half3(tmpvar_13);
  c_9.w = (tmpvar_12 * (atten_8 * (half)4.0));
  float3 tmpvar_14;
  tmpvar_14 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_15;
  lightDir_15 = half3(tmpvar_14);
  half3 normal_16;
  normal_16 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  half4 tmpvar_18;
  tmpvar_18 = (c_9 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_17))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_17))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * tmpvar_18.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 25 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
"ps_3_0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dp4_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c0
dp3_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
dp3_pp r0.y, v1, v1
mul_pp r1.xyz, r0.x, c0
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
dp3_pp r1.y, r0, r1
dp3_pp r1.x, v1, r2
add_pp r1.z, r1.x, c3
mov_pp r0.xyz, c2
frc_pp r1.w, r1.z
mul_pp r0.xyz, c1, r0
mul_pp r0.xyz, r1.y, r0
mul_pp r0.w, r1.y, c3.x
add_pp_sat r1.z, r1, -r1.w
add_pp r1.y, r1.z, c3.w
mul_pp_sat r1.x, -r1, c3.y
mad_pp r1.x, r1, r1.y, c4
mul r0.xyz, r0, c3.x
mul_pp r0, r0, r1.x
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Vector 176 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedhdkcgkkihciclepeegeonfejfbhilkhaabaaaaaapmadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmacaaaa
eaaaaaaalhaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpbaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiaeadiaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiaea
aaaaiaeaaaaaiaeaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
  float3 xlv_TEXCOORD3;
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
  half3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half3 lightDir_4;
  lightDir_4 = tmpvar_3;
  half3 normal_5;
  normal_5 = half3(_mtl_i.xlv_TEXCOORD3);
  half4 c_6;
  half3 tmpvar_7;
  tmpvar_7 = normalize(lightDir_4);
  lightDir_4 = tmpvar_7;
  half3 tmpvar_8;
  tmpvar_8 = normalize(normal_5);
  normal_5 = tmpvar_8;
  half tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, tmpvar_7);
  float3 tmpvar_10;
  tmpvar_10 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_9) * (half)4.0));
  c_6.xyz = half3(tmpvar_10);
  c_6.w = (tmpvar_9 * (half)4.0);
  half3 tmpvar_11;
  tmpvar_11 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_12;
  lightDir_12 = tmpvar_11;
  half3 normal_13;
  normal_13 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  half4 tmpvar_15;
  tmpvar_15 = (c_6 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_14))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_14))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 33 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.50000000, 0.00000000, 1.00000000, 4.00000000
def c4, 10.00000000, 1.00976563, -1.00000000, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2
dp3_pp r0.x, c0, c0
rsq_pp r0.w, r0.x
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, v1, v1
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
dp3_pp r0.y, r0, r1
dp4 r0.w, c0, c0
rsq r0.z, r0.w
mul r1.xyz, r0.z, c0
rcp r0.x, v2.w
mad r2.xy, v2, r0.x, c3.x
dp3 r0.x, v2, v2
texld r0.w, r2, s0
cmp r0.z, -v2, c3.y, c3
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s1
mul_pp r0.x, r0.z, r0
dp3_pp r0.z, v1, r1
mul_pp r0.w, r0.x, r0.y
add_pp r1.w, r0.z, c4.y
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
mul_pp r1.xyz, r0.y, r1
add_pp_sat r1.w, r1, -r2.x
mul_pp_sat r0.y, -r0.z, c4.x
add_pp r1.w, r1, c4.z
mad_pp r1.w, r0.y, r1, c3.z
mul_pp r0.x, r0, c3.w
mul_pp r0.w, r0, c3
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 30 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedcfbmgknoeimcmpgjlggofbenafnpcflhabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiaeaaaaeaaaaaaabcabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaahgcaabaaaaaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaa
aaaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaafaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajecaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
acaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
  float3 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD6;
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
  float2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD6.xy / _mtl_i.xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD6.xyz, _mtl_i.xlv_TEXCOORD6.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_6)));
  half3 lightDir_8;
  lightDir_8 = half3(tmpvar_3);
  half3 normal_9;
  normal_9 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_10;
  atten_10 = half(((float(
    (_mtl_i.xlv_TEXCOORD6.z > 0.0)
  ) * (float)tmpvar_4.w) * (float)tmpvar_7.w));
  half4 c_11;
  half3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  half3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  half tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  float3 tmpvar_15;
  tmpvar_15 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_14) * (atten_10 * (half)4.0)));
  c_11.xyz = half3(tmpvar_15);
  c_11.w = (tmpvar_14 * (atten_10 * (half)4.0));
  float3 tmpvar_16;
  tmpvar_16 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_17;
  lightDir_17 = half3(tmpvar_16);
  half3 normal_18;
  normal_18 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  half4 tmpvar_20;
  tmpvar_20 = (c_11 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_19))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_19))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 29 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_LightTextureB0] 2D 0
SetTexture 1 [_LightTexture0] CUBE 1
"ps_3_0
dcl_2d s0
dcl_cube s1
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4 r1.w, c0, c0
rsq r0.w, r1.w
mul r1.xyz, r0.w, c0
dp3_pp r0.z, v1, r1
add_pp r1.w, r0.z, c3.z
dp3 r0.x, v2, v2
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
add_pp_sat r1.w, r1, -r2.x
texld r0.w, v2, s1
texld r0.x, r0.x, s0
mul r0.x, r0, r0.w
mul_pp r0.w, r0.x, r0.y
mul_pp r1.xyz, r0.y, r1
mul_pp_sat r0.y, -r0.z, c3
add_pp r1.w, r1, c3
mad_pp r1.w, r0.y, r1, c4.x
mul_pp r0.x, r0, c3
mul_pp r0.w, r0, c3.x
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 25 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedphmnknnccoajmncmlbhbiopcaodfbbfaabaaaaaaoiaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaadaaaaeaaaaaaaomaaaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpbaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaa
aaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
efaaaaajpcaabaaaacaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbcbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
adaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaea
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
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
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD6;
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD6, _mtl_i.xlv_TEXCOORD6);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD6));
  half3 lightDir_7;
  lightDir_7 = half3(tmpvar_3);
  half3 normal_8;
  normal_8 = half3(_mtl_i.xlv_TEXCOORD3);
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
  float3 tmpvar_14;
  tmpvar_14 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_13) * (atten_9 * (half)4.0)));
  c_10.xyz = half3(tmpvar_14);
  c_10.w = (tmpvar_13 * (atten_9 * (half)4.0));
  float3 tmpvar_15;
  tmpvar_15 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_16;
  lightDir_16 = half3(tmpvar_15);
  half3 normal_17;
  normal_17 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  half4 tmpvar_19;
  tmpvar_19 = (c_10 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_18))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_18))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * tmpvar_19.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 27 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
"ps_3_0
dcl_2d s0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xy
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r0.w, c0
dp4_pp r1.w, c0, c0
rsq_pp r0.w, r1.w
mul_pp r2.xyz, r0.w, c0
dp3_pp r1.y, r0, r1
dp3_pp r1.x, v1, r2
add_pp r1.z, r1.x, c3
frc_pp r2.x, r1.z
texld r0.w, v2, s0
mul_pp r0.x, r0.w, r1.y
mul_pp r1.w, r0.x, c3.x
mov_pp r0.xyz, c2
mul_pp r0.xyz, c1, r0
add_pp_sat r1.z, r1, -r2.x
mul_pp r0.xyz, r1.y, r0
add_pp r1.y, r1.z, c3.w
mul_pp_sat r1.x, -r1, c3.y
mul_pp r0.w, r0, c3.x
mad_pp r2.x, r1, r1.y, c4
mul r1.xyz, r0, r0.w
mul_pp r0, r1, r2.x
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 23 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedghcoiaiagldilgaeganecccmboabfimmabaaaaaahaaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiadaaaaeaaaaaaamoaaaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpbaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaiaeadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
  float3 xlv_TEXCOORD3;
  float2 xlv_TEXCOORD6;
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
  half3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half4 tmpvar_4;
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(_mtl_i.xlv_TEXCOORD6));
  half3 lightDir_5;
  lightDir_5 = tmpvar_3;
  half3 normal_6;
  normal_6 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_7;
  atten_7 = tmpvar_4.w;
  half4 c_8;
  half3 tmpvar_9;
  tmpvar_9 = normalize(lightDir_5);
  lightDir_5 = tmpvar_9;
  half3 tmpvar_10;
  tmpvar_10 = normalize(normal_6);
  normal_6 = tmpvar_10;
  half tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_9);
  float3 tmpvar_12;
  tmpvar_12 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_11) * (atten_7 * (half)4.0)));
  c_8.xyz = half3(tmpvar_12);
  c_8.w = (tmpvar_11 * (atten_7 * (half)4.0));
  half3 tmpvar_13;
  tmpvar_13 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_14;
  lightDir_14 = tmpvar_13;
  half3 normal_15;
  normal_15 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  half4 tmpvar_17;
  tmpvar_17 = (c_8 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_16))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_16))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * tmpvar_17.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 38 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.50000000, 1.00000000, 0.00000000, 4.00000000
def c5, 10.00000000, 1.00976563, -1.00000000, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2
dcl_texcoord7 v3
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4 r1.w, c0, c0
rsq r0.w, r1.w
mul r1.xyz, r0.w, c0
texldp r0.x, v3, s2
rcp r0.z, v3.w
mad r0.z, -v3, r0, r0.x
mov r0.w, c1.x
rcp r0.x, v2.w
mad r2.xy, v2, r0.x, c4.x
cmp r0.z, r0, c4.y, r0.w
dp3 r0.x, v2, v2
texld r0.w, r2, s0
cmp r1.w, -v2.z, c4.z, c4.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s1
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r0.z
dp3_pp r0.z, v1, r1
mul_pp r0.w, r0.x, r0.y
add_pp r1.w, r0.z, c5.y
mov_pp r1.xyz, c3
frc_pp r2.x, r1.w
mul_pp r1.xyz, c2, r1
mul_pp r1.xyz, r0.y, r1
add_pp_sat r1.w, r1, -r2.x
mul_pp_sat r0.y, -r0.z, c5.x
add_pp r1.w, r1, c5.z
mad_pp r1.w, r0.y, r1, c4.y
mul_pp r0.x, r0, c4.w
mul_pp r0.w, r0, c4
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 37 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.50000000, 1.00000000, 0.00000000, 4.00000000
def c5, 10.00000000, 1.00976563, -1.00000000, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2
dcl_texcoord7 v3
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4 r1.w, c0, c0
rsq r0.w, r1.w
mul r1.xyz, r0.w, c0
mov r0.x, c1
rcp r0.w, v2.w
mad r2.xy, v2, r0.w, c4.x
add r0.z, c4.y, -r0.x
texldp r0.x, v3, s2
mad r0.z, r0.x, r0, c1.x
dp3 r0.x, v2, v2
texld r0.w, r2, s0
cmp r1.w, -v2.z, c4.z, c4.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s1
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r0.z
dp3_pp r0.z, v1, r1
mul_pp r0.w, r0.x, r0.y
add_pp r1.w, r0.z, c5.y
mov_pp r1.xyz, c3
frc_pp r2.x, r1.w
mul_pp r1.xyz, c2, r1
mul_pp r1.xyz, r0.y, r1
add_pp_sat r1.w, r1, -r2.x
mul_pp_sat r0.y, -r0.z, c5.x
add_pp r1.w, r1, c5.z
mad_pp r1.w, r0.y, r1, c4.y
mul_pp r0.x, r0, c4.w
mul_pp r0.w, r0, c4
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 34 math, 2 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_LightTextureB0] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedniepnhadanegnpmpgjlifhibcejjmepkabaaaaaaiaagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaafaaaaeaaaaaaaemabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
koehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacamb
ebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaahgcaabaaaaaaaaaaa
agbbbaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaa
abaaaaaajgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahhcaabaaaabaaaaaaegbcbaaaagaaaaaa
pgbpbaaaagaaaaaaehaaaaalecaabaaaaaaaaaaaegaabaaaabaaaaaaaghabaaa
acaaaaaaaagabaaaaaaaaaaackaabaaaabaaaaaaaaaaaaajicaabaaaaaaaaaaa
akiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajecaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
acaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
ConstBuffer "$Globals" 48
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightShadowData]
VectorHalf 32 [_LightColor0] 4
VectorHalf 40 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD6;
  float4 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
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
  float2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD6.xy / _mtl_i.xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD6.xyz, _mtl_i.xlv_TEXCOORD6.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_6)));
  half tmpvar_8;
  half shadow_9;
  half tmpvar_10;
  tmpvar_10 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD7).xy / (float)(_mtl_i.xlv_TEXCOORD7).w, (float)(_mtl_i.xlv_TEXCOORD7).z / (float)(_mtl_i.xlv_TEXCOORD7).w);
  float tmpvar_11;
  tmpvar_11 = (_mtl_u._LightShadowData.x + ((float)tmpvar_10 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_9 = half(tmpvar_11);
  tmpvar_8 = shadow_9;
  half3 lightDir_12;
  lightDir_12 = half3(tmpvar_3);
  half3 normal_13;
  normal_13 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_14;
  atten_14 = half((((
    float((_mtl_i.xlv_TEXCOORD6.z > 0.0))
   * (float)tmpvar_4.w) * (float)tmpvar_7.w) * (float)tmpvar_8));
  half4 c_15;
  half3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  half3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  half tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  float3 tmpvar_19;
  tmpvar_19 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_18) * (atten_14 * (half)4.0)));
  c_15.xyz = half3(tmpvar_19);
  c_15.w = (tmpvar_18 * (atten_14 * (half)4.0));
  float3 tmpvar_20;
  tmpvar_20 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_21;
  lightDir_21 = half3(tmpvar_20);
  half3 normal_22;
  normal_22 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  half4 tmpvar_24;
  tmpvar_24 = (c_15 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_23))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_23))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 27 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_ShadowMapTexture] 2D 0
"ps_3_0
dcl_2d s0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.z, r0, r1
dp4_pp r1.w, c0, c0
rsq_pp r0.w, r1.w
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, v1, r1
add_pp r1.w, r0.y, c3.z
texldp r0.x, v2, s0
mul_pp r0.w, r0.x, r0.z
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
add_pp_sat r1.w, r1, -r2.x
mul_pp r1.xyz, r0.z, r1
add_pp r0.z, r1.w, c3.w
mul_pp_sat r0.y, -r0, c3
mad_pp r1.w, r0.y, r0.z, c4.x
mul_pp r0.x, r0, c3
mul_pp r0.w, r0, c3.x
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
SetTexture 0 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedkgfblikmiogclfchjcmoddkddbfoalheabaaaaaaimaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaanfaaaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpbaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaaaoaaaaahmcaabaaaaaaaaaaaagbebaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiaeadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 28 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xy
dcl_texcoord7 v3
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4_pp r1.w, c0, c0
rsq_pp r0.w, r1.w
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.z, v1, r1
add_pp r1.w, r0.z, c3.z
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
add_pp_sat r1.w, r1, -r2.x
texld r0.w, v2, s1
texldp r0.x, v3, s0
mul r0.x, r0.w, r0
mul_pp r0.w, r0.x, r0.y
mul_pp r1.xyz, r0.y, r1
mul_pp_sat r0.y, -r0.z, c3
add_pp r1.w, r1, c3
mad_pp r1.w, r0.y, r1, c4.x
mul_pp r0.x, r0, c3
mul_pp r0.w, r0, c3.x
mul r0.xyz, r1, r0.x
mul_pp r0, r0, r1.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 368
Vector 144 [_LightColor0]
Vector 304 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedpigmjjhpgikjikobbamghhiadgjpdkcfabaaaaaaamafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
adadaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclmadaaaaeaaaaaaaopaaaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
dcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaabbaaaaajbcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpbaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
jgahbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
egiccaaaaaaaaaaabdaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaaaoaaaaahmcaabaaaaaaaaaaaagbebaaaagaaaaaapgbpbaaa
agaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiaeadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 37 math, 2 textures
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_cube s0
dcl_2d s1
def c5, 1.00000000, 0.00392157, 0.00001538, 0.00000006
def c6, 0.97000003, 4.00000000, 10.00000000, 1.00976563
def c7, -1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xyz
dcl_texcoord7 v3.xyz
dp3_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
dp3_pp r0.y, v1, v1
mov_pp r2.xyz, c4
mul_pp r1.xyz, r0.x, c0
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
dp3_pp r1.w, r0, r1
mul_pp r1.xyz, c3, r2
dp3 r0.x, v3, v3
rsq r2.x, r0.x
texld r0, v3, s0
dp4 r0.y, r0, c5
rcp r2.x, r2.x
mul r0.x, r2, c1.w
mad r0.y, -r0.x, c6.x, r0
mov r0.x, c2
cmp r0.y, r0, c5.x, r0.x
dp4 r0.z, c0, c0
rsq r0.z, r0.z
mul r2.xyz, r0.z, c0
dp3_pp r0.w, v1, r2
add_pp r2.y, r0.w, c6.w
dp3 r0.x, v2, v2
texld r0.x, r0.x, s1
mul r2.x, r0, r0.y
mul_pp r1.xyz, r1.w, r1
mul_pp r0.x, r2, c6.y
mul r0.xyz, r1, r0.x
frc_pp r2.z, r2.y
add_pp_sat r1.y, r2, -r2.z
mul_pp_sat r0.w, -r0, c6.z
add_pp r1.y, r1, c7.x
mad_pp r1.y, r0.w, r1, c5.x
mul_pp r1.x, r2, r1.w
mul_pp r0.w, r1.x, c6.y
mul_pp r0, r0, r1.y
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 31 math, 2 textures
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedcaghdfolndmpigbcmbijganpeehekgkbabaaaaaapeafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckeaeaaaaeaaaaaaacjabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaajbcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
omfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaabbaaaaakecaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhafidibdddbaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiaeabaaaaaajecaabaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
SubProgram "metal " {
// Stats: 29 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 64
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
Vector 32 [_LightShadowData]
VectorHalf 48 [_LightColor0] 4
VectorHalf 56 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD6, _mtl_i.xlv_TEXCOORD6);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD7, _mtl_i.xlv_TEXCOORD7)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float4 packDist_7;
  half4 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(_mtl_i.xlv_TEXCOORD7));
  packDist_7 = float4(tmpvar_8);
  float tmpvar_9;
  tmpvar_9 = dot (packDist_7, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float tmpvar_10;
  if ((tmpvar_9 < tmpvar_6)) {
    tmpvar_10 = _mtl_u._LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  half3 lightDir_11;
  lightDir_11 = half3(tmpvar_3);
  half3 normal_12;
  normal_12 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_13;
  atten_13 = half(((float)tmpvar_5.w * tmpvar_10));
  half4 c_14;
  half3 tmpvar_15;
  tmpvar_15 = normalize(lightDir_11);
  lightDir_11 = tmpvar_15;
  half3 tmpvar_16;
  tmpvar_16 = normalize(normal_12);
  normal_12 = tmpvar_16;
  half tmpvar_17;
  tmpvar_17 = dot (tmpvar_16, tmpvar_15);
  float3 tmpvar_18;
  tmpvar_18 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_17) * (atten_13 * (half)4.0)));
  c_14.xyz = half3(tmpvar_18);
  c_14.w = (tmpvar_17 * (atten_13 * (half)4.0));
  float3 tmpvar_19;
  tmpvar_19 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_20;
  lightDir_20 = half3(tmpvar_19);
  half3 normal_21;
  normal_21 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  half4 tmpvar_23;
  tmpvar_23 = (c_14 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_22))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_22))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * tmpvar_23.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 38 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
"ps_3_0
dcl_cube s0
dcl_2d s1
dcl_cube s2
def c5, 1.00000000, 0.00392157, 0.00001538, 0.00000006
def c6, 0.97000003, 4.00000000, 10.00000000, 1.00976563
def c7, -1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xyz
dcl_texcoord7 v3.xyz
mov_pp r0.xyz, c4
mul_pp r2.xyz, c3, r0
dp3_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
dp3_pp r0.y, v1, v1
mul_pp r1.xyz, r0.x, c0
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
dp3_pp r1.w, r0, r1
texld r0, v3, s0
dp4 r0.y, r0, c5
mul_pp r1.xyz, r1.w, r2
dp3 r2.x, v3, v3
rsq r2.x, r2.x
rcp r0.x, r2.x
mul r0.x, r0, c1.w
mad r2.x, -r0, c6, r0.y
dp4 r0.z, c0, c0
mov r0.w, c2.x
cmp r2.x, r2, c5, r0.w
rsq r0.x, r0.z
mul r0.xyz, r0.x, c0
dp3_pp r0.y, v1, r0
dp3 r0.x, v2, v2
texld r0.w, v2, s2
texld r0.x, r0.x, s1
mul r0.x, r0, r0.w
mul r0.x, r0, r2
add_pp r0.w, r0.y, c6
mul_pp r0.z, r0.x, c6.y
mul_pp r0.x, r0, r1.w
frc_pp r2.x, r0.w
mul r1.xyz, r1, r0.z
add_pp_sat r0.z, r0.w, -r2.x
add_pp r0.z, r0, c7.x
mul_pp_sat r0.y, -r0, c6.z
mad_pp r0.y, r0, r0.z, c5.x
mul_pp r1.w, r0.x, c6.y
mul_pp r0, r1, r0.y
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 32 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_LightTextureB0] 2D 2
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedbnihgidpandenkfhifpaajanilnccdkeabaaaaaafaagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaafaaaaeaaaaaaaeaabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaajbcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
koehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacamb
ebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaabaaaaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaomfbhidp
efaaaaajpcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaabbaaaaakecaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhafidibdddbaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiaeabaaaaaajecaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaa
aaaaaaaaegbcbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
SubProgram "metal " {
// Stats: 30 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 64
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
Vector 32 [_LightShadowData]
VectorHalf 48 [_LightColor0] 4
VectorHalf 56 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD6, _mtl_i.xlv_TEXCOORD6);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD6));
  float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD7, _mtl_i.xlv_TEXCOORD7)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float4 packDist_8;
  half4 tmpvar_9;
  tmpvar_9 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(_mtl_i.xlv_TEXCOORD7));
  packDist_8 = float4(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = dot (packDist_8, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float tmpvar_11;
  if ((tmpvar_10 < tmpvar_7)) {
    tmpvar_11 = _mtl_u._LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  half3 lightDir_12;
  lightDir_12 = half3(tmpvar_3);
  half3 normal_13;
  normal_13 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_14;
  atten_14 = half(((float)(tmpvar_5.w * tmpvar_6.w) * tmpvar_11));
  half4 c_15;
  half3 tmpvar_16;
  tmpvar_16 = normalize(lightDir_12);
  lightDir_12 = tmpvar_16;
  half3 tmpvar_17;
  tmpvar_17 = normalize(normal_13);
  normal_13 = tmpvar_17;
  half tmpvar_18;
  tmpvar_18 = dot (tmpvar_17, tmpvar_16);
  float3 tmpvar_19;
  tmpvar_19 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_18) * (atten_14 * (half)4.0)));
  c_15.xyz = half3(tmpvar_19);
  c_15.w = (tmpvar_18 * (atten_14 * (half)4.0));
  float3 tmpvar_20;
  tmpvar_20 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_21;
  lightDir_21 = half3(tmpvar_20);
  half3 normal_22;
  normal_22 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  half4 tmpvar_24;
  tmpvar_24 = (c_15 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_23))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_23))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * tmpvar_24.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 46 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_LightColor0]
Vector 7 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 0.50000000, 1.00000000, 0.25000000, 0.00000000
def c9, 4.00000000, 10.00000000, 1.00976563, -1.00000000
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2
dcl_texcoord7 v3
mov_pp r1.xyz, c7
dp3_pp r0.y, c0, c0
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rcp r0.w, v3.w
mul_pp r1.xyz, c6, r1
mul_pp r2.xyz, r0.y, c0
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
dp3_pp r0.z, r0, r2
mul_pp r2.xyz, r0.z, r1
mad r0.xy, v3, r0.w, c5
mad r1.xy, v3, r0.w, c4
texld r0.x, r0, s2
texld r1.x, r1, s2
mov r1.w, r0.x
mad r0.xy, v3, r0.w, c3
texld r0.x, r0, s2
mov r1.z, r1.x
mad r1.xy, v3, r0.w, c2
texld r1.x, r1, s2
mov r1.y, r0.x
dp4 r0.x, c0, c0
mad r1, -v3.z, r0.w, r1
mov r0.y, c1.x
cmp r1, r1, c8.y, r0.y
dp4_pp r0.y, r1, c8.z
rsq r0.x, r0.x
mul r1.xyz, r0.x, c0
dp3_pp r1.z, v1, r1
rcp r0.x, v2.w
mad r1.xy, v2, r0.x, c8.x
texld r0.w, r1, s0
cmp r1.x, -v2.z, c8.w, c8.y
dp3 r0.x, v2, v2
mul_pp r0.w, r1.x, r0
texld r0.x, r0.x, s1
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r0.y
mul_pp r0.y, r0.x, c9.x
mul_pp r0.x, r0, r0.z
add_pp r0.w, r1.z, c9.z
frc_pp r1.x, r0.w
mul r2.xyz, r2, r0.y
add_pp_sat r0.y, r0.w, -r1.x
add_pp r0.z, r0.y, c9.w
mul_pp_sat r0.y, -r1.z, c9
mad_pp r0.y, r0, r0.z, c8
mul_pp r2.w, r0.x, c9.x
mul_pp r0, r2, r0.y
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 46 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_LightColor0]
Vector 7 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 0.50000000, 1.00000000, 0.25000000, 0.00000000
def c9, 4.00000000, 10.00000000, 1.00976563, -1.00000000
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2
dcl_texcoord7 v3
rcp r1.w, v3.w
mad r0.xyz, v3, r1.w, c5
mad r1.xyz, v3, r1.w, c3
texld r0.x, r0, s2
mov_pp r0.w, r0.x
mad r0.xyz, v3, r1.w, c4
texld r0.x, r0, s2
mov_pp r0.z, r0.x
texld r1.x, r1, s2
mov_pp r0.y, r1.x
mad r1.xyz, v3, r1.w, c2
mov r0.x, c1
add r1.w, c8.y, -r0.x
texld r0.x, r1, s2
mad r1, r0, r1.w, c1.x
dp4_pp r0.z, r1, c8.z
rcp r0.x, v2.w
mad r1.xy, v2, r0.x, c8.x
dp3 r0.x, v2, v2
texld r0.w, r1, s0
cmp r0.y, -v2.z, c8.w, c8
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s1
mul_pp r0.x, r0.y, r0
mul_pp r0.w, r0.x, r0.z
dp3_pp r0.y, c0, c0
rsq_pp r1.x, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mul_pp r1.xyz, r1.x, c0
dp3_pp r1.z, r0, r1
mul_pp r1.x, r0.w, r1.z
dp4 r1.w, c0, c0
rsq r0.x, r1.w
mul r0.xyz, r0.x, c0
mul_pp r1.w, r1.x, c9.x
dp3_pp r1.x, v1, r0
add_pp r1.y, r1.x, c9.z
frc_pp r2.x, r1.y
add_pp_sat r1.y, r1, -r2.x
mov_pp r0.xyz, c7
mul_pp r0.xyz, c6, r0
mul_pp r0.xyz, r1.z, r0
mul_pp r0.w, r0, c9.x
add_pp r1.y, r1, c9.w
mul_pp_sat r1.x, -r1, c9.y
mad_pp r2.x, r1, r1.y, c8.y
mul r1.xyz, r0, r0.w
mul_pp r0, r1, r2.x
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 39 math, 2 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_LightTextureB0] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 368
Vector 16 [_ShadowOffsets0]
Vector 32 [_ShadowOffsets1]
Vector 48 [_ShadowOffsets2]
Vector 64 [_ShadowOffsets3]
Vector 144 [_LightColor0]
Vector 304 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedbpanjeoafmnbbjphdboocfjdcmionfmjabaaaaaakmahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfmagaaaaeaaaaaaajhabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpaoaaaaahocaabaaa
aaaaaaaaagbjbaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaaihcaabaaaabaaaaaa
jgahbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaehaaaaalbcaabaaaabaaaaaa
egaabaaaabaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaaabaaaaaa
aaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaa
ehaaaaalccaabaaaabaaaaaaegaabaaaacaaaaaaaghabaaaacaaaaaaaagabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agijcaaaaaaaaaaaaeaaaaaaehaaaaalicaabaaaabaaaaaajgafbaaaaaaaaaaa
aghabaaaacaaaaaaaagabaaaaaaaaaaadkaabaaaaaaaaaaaehaaaaalecaabaaa
abaaaaaaegaabaaaacaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaa
acaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaa
agiacaaaacaaaaaabiaaaaaabbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadoaoaaaaahgcaabaaaaaaaaaaa
agbbbaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaa
abaaaaaajgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiaeabaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaa
aaaaaaaabdaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaabbaaaaaj
bcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
Vector 16 [_LightShadowData]
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
  float3 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD6;
  float4 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
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
  float2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD6.xy / _mtl_i.xlv_TEXCOORD6.w) + 0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD6.xyz, _mtl_i.xlv_TEXCOORD6.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_6)));
  half tmpvar_8;
  half4 shadows_9;
  float3 tmpvar_10;
  tmpvar_10 = (_mtl_i.xlv_TEXCOORD7.xyz / _mtl_i.xlv_TEXCOORD7.w);
  float3 coord_11;
  coord_11 = (tmpvar_10 + _mtl_u._ShadowOffsets[0].xyz);
  half tmpvar_12;
  tmpvar_12 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_11).xy, (float)(coord_11).z);
  shadows_9.x = tmpvar_12;
  float3 coord_13;
  coord_13 = (tmpvar_10 + _mtl_u._ShadowOffsets[1].xyz);
  half tmpvar_14;
  tmpvar_14 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_13).xy, (float)(coord_13).z);
  shadows_9.y = tmpvar_14;
  float3 coord_15;
  coord_15 = (tmpvar_10 + _mtl_u._ShadowOffsets[2].xyz);
  half tmpvar_16;
  tmpvar_16 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_15).xy, (float)(coord_15).z);
  shadows_9.z = tmpvar_16;
  float3 coord_17;
  coord_17 = (tmpvar_10 + _mtl_u._ShadowOffsets[3].xyz);
  half tmpvar_18;
  tmpvar_18 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(coord_17).xy, (float)(coord_17).z);
  shadows_9.w = tmpvar_18;
  float4 tmpvar_19;
  tmpvar_19 = (_mtl_u._LightShadowData.xxxx + ((float4)shadows_9 * (1.0 - _mtl_u._LightShadowData.xxxx)));
  shadows_9 = half4(tmpvar_19);
  half tmpvar_20;
  tmpvar_20 = dot (shadows_9, (half4)float4(0.25, 0.25, 0.25, 0.25));
  tmpvar_8 = tmpvar_20;
  half3 lightDir_21;
  lightDir_21 = half3(tmpvar_3);
  half3 normal_22;
  normal_22 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_23;
  atten_23 = half((((
    float((_mtl_i.xlv_TEXCOORD6.z > 0.0))
   * (float)tmpvar_4.w) * (float)tmpvar_7.w) * (float)tmpvar_8));
  half4 c_24;
  half3 tmpvar_25;
  tmpvar_25 = normalize(lightDir_21);
  lightDir_21 = tmpvar_25;
  half3 tmpvar_26;
  tmpvar_26 = normalize(normal_22);
  normal_22 = tmpvar_26;
  half tmpvar_27;
  tmpvar_27 = dot (tmpvar_26, tmpvar_25);
  float3 tmpvar_28;
  tmpvar_28 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_27) * (atten_23 * (half)4.0)));
  c_24.xyz = half3(tmpvar_28);
  c_24.w = (tmpvar_27 * (atten_23 * (half)4.0));
  float3 tmpvar_29;
  tmpvar_29 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_30;
  lightDir_30 = half3(tmpvar_29);
  half3 normal_31;
  normal_31 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_32;
  tmpvar_32 = dot (normal_31, lightDir_30);
  half4 tmpvar_33;
  tmpvar_33 = (c_24 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_32))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_32))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_33.w;
  color_2.xyz = (tmpvar_33.xyz * tmpvar_33.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 45 math, 5 textures
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_cube s0
dcl_2d s1
def c5, 0.00781250, -0.00781250, 0.97000003, 1.00000000
def c6, 1.00000000, 0.00392157, 0.00001538, 0.00000006
def c7, 0.25000000, 4.00000000, 10.00000000, 1.00976563
def c8, -1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xyz
dcl_texcoord7 v3.xyz
add r0.xyz, v3, c5.xyyw
texld r0, r0, s0
dp4 r2.w, r0, c6
add r0.xyz, v3, c5.yxyw
texld r0, r0, s0
dp4 r2.z, r0, c6
add r1.xyz, v3, c5.yyxw
texld r1, r1, s0
dp4 r2.y, r1, c6
add r0.xyz, v3, c5.x
texld r0, r0, s0
dp3 r1.x, v3, v3
dp4 r2.x, r0, c6
rsq r1.x, r1.x
rcp r0.x, r1.x
mul r0.x, r0, c1.w
mad r0, -r0.x, c5.z, r2
mov r1.x, c2
cmp r1, r0, c5.w, r1.x
dp3 r0.x, v2, v2
dp4_pp r0.y, r1, c7.x
texld r0.x, r0.x, s1
mul r1.w, r0.x, r0.y
dp3_pp r0.y, c0, c0
rsq_pp r0.w, r0.y
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
dp3_pp r1.x, r0, r1
dp4 r0.w, c0, c0
rsq r0.x, r0.w
mul_pp r0.w, r1, r1.x
mul r0.xyz, r0.x, c0
dp3_pp r1.z, v1, r0
mul_pp r1.y, r1.w, c7
add_pp r1.w, r1.z, c7
mov_pp r0.xyz, c4
frc_pp r2.x, r1.w
mul_pp r0.xyz, c3, r0
mul_pp r0.xyz, r1.x, r0
add_pp_sat r1.w, r1, -r2.x
mul_pp r0.w, r0, c7.y
add_pp r1.w, r1, c8.x
mul_pp_sat r1.x, -r1.z, c7.z
mad_pp r1.x, r1, r1.w, c5.w
mul r0.xyz, r0, r1.y
mul_pp r0, r0, r1.x
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 39 math, 5 textures
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_LightTexture0] 2D 1
SetTexture 1 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedmbhnidccbbahjhhcmmnhlbbmkfmgbdfnabaaaaaakmahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfmagaaaaeaaaaaaajhabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
omfbhidpaaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaadmaaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhafidibddaaaaaaakocaabaaa
aaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaabbaaaaakccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhafidibddaaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaa
jgahbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaa
abaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhafidibdd
aaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadm
aaaaaalmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhafidibdddbaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiaeabaaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaa
aaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaabbaaaaaj
bcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
SubProgram "metal " {
// Stats: 40 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 64
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
Vector 32 [_LightShadowData]
VectorHalf 48 [_LightColor0] 4
VectorHalf 56 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  float3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  float tmpvar_4;
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD6, _mtl_i.xlv_TEXCOORD6);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  float tmpvar_6;
  float4 shadowVals_7;
  float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD7, _mtl_i.xlv_TEXCOORD7)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float3 vec_9;
  vec_9 = (_mtl_i.xlv_TEXCOORD7 + float3(0.0078125, 0.0078125, 0.0078125));
  float4 packDist_10;
  half4 tmpvar_11;
  tmpvar_11 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_9));
  packDist_10 = float4(tmpvar_11);
  shadowVals_7.x = dot (packDist_10, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_12;
  vec_12 = (_mtl_i.xlv_TEXCOORD7 + float3(-0.0078125, -0.0078125, 0.0078125));
  float4 packDist_13;
  half4 tmpvar_14;
  tmpvar_14 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_12));
  packDist_13 = float4(tmpvar_14);
  shadowVals_7.y = dot (packDist_13, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_15;
  vec_15 = (_mtl_i.xlv_TEXCOORD7 + float3(-0.0078125, 0.0078125, -0.0078125));
  float4 packDist_16;
  half4 tmpvar_17;
  tmpvar_17 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_15));
  packDist_16 = float4(tmpvar_17);
  shadowVals_7.z = dot (packDist_16, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_18;
  vec_18 = (_mtl_i.xlv_TEXCOORD7 + float3(0.0078125, -0.0078125, -0.0078125));
  float4 packDist_19;
  half4 tmpvar_20;
  tmpvar_20 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_18));
  packDist_19 = float4(tmpvar_20);
  shadowVals_7.w = dot (packDist_19, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bool4 tmpvar_21;
  tmpvar_21 = bool4((shadowVals_7 < float4(tmpvar_8)));
  float4 tmpvar_22;
  tmpvar_22 = _mtl_u._LightShadowData.xxxx;
  float tmpvar_23;
  if (tmpvar_21.x) {
    tmpvar_23 = tmpvar_22.x;
  } else {
    tmpvar_23 = 1.0;
  };
  float tmpvar_24;
  if (tmpvar_21.y) {
    tmpvar_24 = tmpvar_22.y;
  } else {
    tmpvar_24 = 1.0;
  };
  float tmpvar_25;
  if (tmpvar_21.z) {
    tmpvar_25 = tmpvar_22.z;
  } else {
    tmpvar_25 = 1.0;
  };
  float tmpvar_26;
  if (tmpvar_21.w) {
    tmpvar_26 = tmpvar_22.w;
  } else {
    tmpvar_26 = 1.0;
  };
  half4 tmpvar_27;
  tmpvar_27.x = half(tmpvar_23);
  tmpvar_27.y = half(tmpvar_24);
  tmpvar_27.z = half(tmpvar_25);
  tmpvar_27.w = half(tmpvar_26);
  half tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, (half4)float4(0.25, 0.25, 0.25, 0.25));
  tmpvar_6 = float(tmpvar_28);
  half3 lightDir_29;
  lightDir_29 = half3(tmpvar_3);
  half3 normal_30;
  normal_30 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_31;
  atten_31 = half(((float)tmpvar_5.w * tmpvar_6));
  half4 c_32;
  half3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_29);
  lightDir_29 = tmpvar_33;
  half3 tmpvar_34;
  tmpvar_34 = normalize(normal_30);
  normal_30 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (tmpvar_34, tmpvar_33);
  float3 tmpvar_36;
  tmpvar_36 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_35) * (atten_31 * (half)4.0)));
  c_32.xyz = half3(tmpvar_36);
  c_32.w = (tmpvar_35 * (atten_31 * (half)4.0));
  float3 tmpvar_37;
  tmpvar_37 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_38;
  lightDir_38 = half3(tmpvar_37);
  half3 normal_39;
  normal_39 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  half4 tmpvar_41;
  tmpvar_41 = (c_32 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_40))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_40))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * tmpvar_41.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 46 math, 6 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
"ps_3_0
dcl_cube s0
dcl_2d s1
dcl_cube s2
def c5, 0.00781250, -0.00781250, 0.97000003, 1.00000000
def c6, 1.00000000, 0.00392157, 0.00001538, 0.00000006
def c7, 0.25000000, 4.00000000, 10.00000000, 1.00976563
def c8, -1.00000000, 0, 0, 0
dcl_texcoord3 v1.xyz
dcl_texcoord6 v2.xyz
dcl_texcoord7 v3.xyz
add r0.xyz, v3, c5.xyyw
texld r0, r0, s0
dp4 r2.w, r0, c6
add r0.xyz, v3, c5.yxyw
texld r0, r0, s0
dp4 r2.z, r0, c6
add r1.xyz, v3, c5.yyxw
texld r1, r1, s0
dp4 r2.y, r1, c6
add r0.xyz, v3, c5.x
texld r0, r0, s0
dp3 r1.x, v3, v3
dp4 r2.x, r0, c6
rsq r1.x, r1.x
rcp r0.x, r1.x
mul r0.x, r0, c1.w
mad r0, -r0.x, c5.z, r2
mov r1.x, c2
cmp r0, r0, c5.w, r1.x
dp4_pp r0.y, r0, c7.x
dp3 r0.x, v2, v2
texld r0.w, v2, s2
texld r0.x, r0.x, s1
mul r0.x, r0, r0.w
mul r1.w, r0.x, r0.y
dp3_pp r0.y, c0, c0
rsq_pp r0.w, r0.y
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
dp3_pp r1.x, r0, r1
dp4 r0.w, c0, c0
rsq r0.x, r0.w
mul_pp r0.w, r1, r1.x
mul r0.xyz, r0.x, c0
dp3_pp r1.z, v1, r0
mul_pp r1.y, r1.w, c7
add_pp r1.w, r1.z, c7
mov_pp r0.xyz, c4
frc_pp r2.x, r1.w
mul_pp r0.xyz, c3, r0
mul_pp r0.xyz, r1.x, r0
add_pp_sat r1.w, r1, -r2.x
mul_pp r0.w, r0, c7.y
add_pp r1.w, r1, c8.x
mul_pp_sat r1.x, -r1.z, c7.z
mad_pp r1.x, r1, r1.w, c5.w
mul r0.xyz, r0, r1.y
mul_pp r0, r0, r1.x
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 40 math, 6 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_LightTextureB0] 2D 2
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 304
Vector 80 [_LightColor0]
Vector 240 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedebneopidkiebolegfeafnlkeihjfbhbkabaaaaaaaiaiaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaabaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcliagaaaaeaaaaaaakoabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidp
aaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadm
aaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhafidibddaaaaaaakocaabaaaaaaaaaaa
agbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadmefaaaaaj
pcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
bbaaaaakccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadl
icabibdhafidibddaaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaaabaaaaaa
egaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhafidibddaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalm
aaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhafidibdddbaaaaahpcaabaaaaaaaaaaaegaobaaa
abaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
agiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
baaaaaajccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
adaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaa
apaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajbcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
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
SubProgram "metal " {
// Stats: 41 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_ShadowMapTexture] CUBE 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 64
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
Vector 32 [_LightShadowData]
VectorHalf 48 [_LightColor0] 4
VectorHalf 56 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  float4 _LightPositionRange;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD6, _mtl_i.xlv_TEXCOORD6);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD6));
  float tmpvar_7;
  float4 shadowVals_8;
  float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD7, _mtl_i.xlv_TEXCOORD7)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float3 vec_10;
  vec_10 = (_mtl_i.xlv_TEXCOORD7 + float3(0.0078125, 0.0078125, 0.0078125));
  float4 packDist_11;
  half4 tmpvar_12;
  tmpvar_12 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_10));
  packDist_11 = float4(tmpvar_12);
  shadowVals_8.x = dot (packDist_11, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_13;
  vec_13 = (_mtl_i.xlv_TEXCOORD7 + float3(-0.0078125, -0.0078125, 0.0078125));
  float4 packDist_14;
  half4 tmpvar_15;
  tmpvar_15 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_13));
  packDist_14 = float4(tmpvar_15);
  shadowVals_8.y = dot (packDist_14, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_16;
  vec_16 = (_mtl_i.xlv_TEXCOORD7 + float3(-0.0078125, 0.0078125, -0.0078125));
  float4 packDist_17;
  half4 tmpvar_18;
  tmpvar_18 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_16));
  packDist_17 = float4(tmpvar_18);
  shadowVals_8.z = dot (packDist_17, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_19;
  vec_19 = (_mtl_i.xlv_TEXCOORD7 + float3(0.0078125, -0.0078125, -0.0078125));
  float4 packDist_20;
  half4 tmpvar_21;
  tmpvar_21 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_19));
  packDist_20 = float4(tmpvar_21);
  shadowVals_8.w = dot (packDist_20, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  bool4 tmpvar_22;
  tmpvar_22 = bool4((shadowVals_8 < float4(tmpvar_9)));
  float4 tmpvar_23;
  tmpvar_23 = _mtl_u._LightShadowData.xxxx;
  float tmpvar_24;
  if (tmpvar_22.x) {
    tmpvar_24 = tmpvar_23.x;
  } else {
    tmpvar_24 = 1.0;
  };
  float tmpvar_25;
  if (tmpvar_22.y) {
    tmpvar_25 = tmpvar_23.y;
  } else {
    tmpvar_25 = 1.0;
  };
  float tmpvar_26;
  if (tmpvar_22.z) {
    tmpvar_26 = tmpvar_23.z;
  } else {
    tmpvar_26 = 1.0;
  };
  float tmpvar_27;
  if (tmpvar_22.w) {
    tmpvar_27 = tmpvar_23.w;
  } else {
    tmpvar_27 = 1.0;
  };
  half4 tmpvar_28;
  tmpvar_28.x = half(tmpvar_24);
  tmpvar_28.y = half(tmpvar_25);
  tmpvar_28.z = half(tmpvar_26);
  tmpvar_28.w = half(tmpvar_27);
  half tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, (half4)float4(0.25, 0.25, 0.25, 0.25));
  tmpvar_7 = float(tmpvar_29);
  half3 lightDir_30;
  lightDir_30 = half3(tmpvar_3);
  half3 normal_31;
  normal_31 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_32;
  atten_32 = half(((float)(tmpvar_5.w * tmpvar_6.w) * tmpvar_7));
  half4 c_33;
  half3 tmpvar_34;
  tmpvar_34 = normalize(lightDir_30);
  lightDir_30 = tmpvar_34;
  half3 tmpvar_35;
  tmpvar_35 = normalize(normal_31);
  normal_31 = tmpvar_35;
  half tmpvar_36;
  tmpvar_36 = dot (tmpvar_35, tmpvar_34);
  float3 tmpvar_37;
  tmpvar_37 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_36) * (atten_32 * (half)4.0)));
  c_33.xyz = half3(tmpvar_37);
  c_33.w = (tmpvar_36 * (atten_32 * (half)4.0));
  float3 tmpvar_38;
  tmpvar_38 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_39;
  lightDir_39 = half3(tmpvar_38);
  half3 normal_40;
  normal_40 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  half4 tmpvar_42;
  tmpvar_42 = (c_33 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_41))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_41))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * tmpvar_42.w);
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
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
// Stats: 23 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 48
VectorHalf 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightShadowData]
VectorHalf 32 [_LightColor0] 4
VectorHalf 40 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD6;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  half3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half shadow_4;
  half tmpvar_5;
  tmpvar_5 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD6.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD6.xyz).z);
  half tmpvar_6;
  tmpvar_6 = tmpvar_5;
  float tmpvar_7;
  tmpvar_7 = (_mtl_u._LightShadowData.x + ((float)tmpvar_6 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_4 = half(tmpvar_7);
  half3 lightDir_8;
  lightDir_8 = tmpvar_3;
  half3 normal_9;
  normal_9 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_10;
  atten_10 = shadow_4;
  half4 c_11;
  half3 tmpvar_12;
  tmpvar_12 = normalize(lightDir_8);
  lightDir_8 = tmpvar_12;
  half3 tmpvar_13;
  tmpvar_13 = normalize(normal_9);
  normal_9 = tmpvar_13;
  half tmpvar_14;
  tmpvar_14 = dot (tmpvar_13, tmpvar_12);
  float3 tmpvar_15;
  tmpvar_15 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_14) * (atten_10 * (half)4.0)));
  c_11.xyz = half3(tmpvar_15);
  c_11.w = (tmpvar_14 * (atten_10 * (half)4.0));
  half3 tmpvar_16;
  tmpvar_16 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_17;
  lightDir_17 = tmpvar_16;
  half3 normal_18;
  normal_18 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  half4 tmpvar_20;
  tmpvar_20 = (c_11 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_19))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_19))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
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
// Stats: 24 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 48
VectorHalf 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightShadowData]
VectorHalf 32 [_LightColor0] 4
VectorHalf 40 [_Color] 4
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD3;
  float2 xlv_TEXCOORD6;
  float4 xlv_TEXCOORD7;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(1)]], sampler _mtlsmp__LightTexture0 [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2 = _mtl_u._Color;
  half3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half4 tmpvar_4;
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(_mtl_i.xlv_TEXCOORD6));
  half shadow_5;
  half tmpvar_6;
  tmpvar_6 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD7.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD7.xyz).z);
  half tmpvar_7;
  tmpvar_7 = tmpvar_6;
  float tmpvar_8;
  tmpvar_8 = (_mtl_u._LightShadowData.x + ((float)tmpvar_7 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_5 = half(tmpvar_8);
  half3 lightDir_9;
  lightDir_9 = tmpvar_3;
  half3 normal_10;
  normal_10 = half3(_mtl_i.xlv_TEXCOORD3);
  half atten_11;
  atten_11 = (tmpvar_4.w * shadow_5);
  half4 c_12;
  half3 tmpvar_13;
  tmpvar_13 = normalize(lightDir_9);
  lightDir_9 = tmpvar_13;
  half3 tmpvar_14;
  tmpvar_14 = normalize(normal_10);
  normal_10 = tmpvar_14;
  half tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_13);
  float3 tmpvar_16;
  tmpvar_16 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_15) * (atten_11 * (half)4.0)));
  c_12.xyz = half3(tmpvar_16);
  c_12.w = (tmpvar_15 * (atten_11 * (half)4.0));
  half3 tmpvar_17;
  tmpvar_17 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_18;
  lightDir_18 = tmpvar_17;
  half3 normal_19;
  normal_19 = half3(_mtl_i.xlv_TEXCOORD3);
  half tmpvar_20;
  tmpvar_20 = dot (normal_19, lightDir_18);
  half4 tmpvar_21;
  tmpvar_21 = (c_12 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_20))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_20))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_21.w;
  color_2.xyz = (tmpvar_21.xyz * tmpvar_21.w);
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