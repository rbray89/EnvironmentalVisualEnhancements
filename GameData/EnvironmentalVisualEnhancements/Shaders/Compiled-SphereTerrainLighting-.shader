// Compiled shader for all platforms, uncompressed size: 468.7KB

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
 //        d3d9 : 42 avg math (37..46)
 //        gles : 29 avg math (19..42), 2 avg texture (0..6), 0 avg branch (0..4)
 //       gles3 : 28 avg math (19..42), 2 avg texture (0..6), 0 avg branch (0..4)
 //   glesdesktop : 29 avg math (19..42), 2 avg texture (0..6), 1 avg branch (0..4)
 //       metal : 22 avg math (21..23)
 //      opengl : 29 avg math (19..42), 2 avg texture (0..6), 1 avg branch (0..4)
 // Stats for Fragment shader:
 //       d3d11 : 30 avg math (23..41), 2 avg texture (0..6)
 //        d3d9 : 36 avg math (26..47), 2 avg texture (0..6)
 //       metal : 28 avg math (19..42), 2 avg texture (0..6), 0 avg branch (0..4)
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderMode"="Transparent" }
  Lighting On
  ZWrite Off
  Blend SrcColor SrcAlpha, One Zero
Program "vp" {
SubProgram "opengl " {
// Stats: 22 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
def c14, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c14.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c14.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o4.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
mul_sat r0.x, -r1.w, c14.y
add r0.y, r0, c14.w
mad o6.x, r0, r0.y, c15
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o7.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o5.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedoaehlmoahhchelnbdgpnlmacnfbcafifabaaaaaaoeahaaaaadaaaaaa
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
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
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
aaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
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
// Stats: 22 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp vec3 tmpvar_13;
  tmpvar_13 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.xyz = tmpvar_13;
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD4;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * (2.0 * tmpvar_18.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 22 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp vec3 tmpvar_13;
  tmpvar_13 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.xyz = tmpvar_13;
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD4;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * (2.0 * tmpvar_18.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 22 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
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
  tmpvar_5 = texture (_LightTexture0, vec2(tmpvar_4));
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
  highp vec3 tmpvar_13;
  tmpvar_13 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_12) * (atten_8 * 4.0));
  c_9.xyz = tmpvar_13;
  c_9.w = (tmpvar_12 * (atten_8 * 4.0));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_15;
  lightDir_15 = tmpvar_14;
  mediump vec3 normal_16;
  normal_16 = xlv_TEXCOORD4;
  mediump float tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (c_9 * mix (1.0, clamp (
    floor((1.01 + tmpvar_17))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_17))
  , 0.0, 1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * (2.0 * tmpvar_18.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 224
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
Matrix 160 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7).xyz;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
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
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_2 - _WorldSpaceCameraPos));
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
  c_2.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_3) * 4.0);
  c_2.w = (tmpvar_3 * 4.0);
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_5;
  tmpvar_5 = (c_2 * mix (1.0, clamp (
    floor((1.01 + tmpvar_4))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_4))
  , 0.0, 1.0)));
  color_1.w = tmpvar_5.w;
  color_1.xyz = (tmpvar_5.xyz * (2.0 * tmpvar_5.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 37 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
def c10, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c11, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c9, c9
rsq r0.x, r0.x
mul r1.xyz, r0.x, c9
mov r1.w, c10.x
mov r0.xy, v3
mov r0.z, v4.x
dp3 r0.w, -r0, r1
mov r1.xyz, v2
dp4 r2.x, r1, c4
dp4 r2.z, r1, c6
dp4 r2.y, r1, c5
add r2.w, r0, c10.z
dp3 r1.x, r2, r2
rsq r1.x, r1.x
mul o3.xyz, r1.x, r2
frc r1.y, r2.w
add_sat r1.y, r2.w, -r1
add r1.w, r1.y, c10
mul_sat r2.x, -r0.w, c10.y
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r1.xyz, -r1, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mad o5.x, r2, r1.w, c11
mov o1, v1
mul o6.xyz, r0.w, -r1
mov o2.xyz, v2
rcp o2.w, r0.w
mov o4.xyz, -r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
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
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD4;
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
  normal_5 = xlv_TEXCOORD4;
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
  normal_13 = xlv_TEXCOORD4;
  mediump float tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * (2.0 * tmpvar_15.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec3 xlv_TEXCOORD4;
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
  normal_5 = xlv_TEXCOORD4;
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
  normal_13 = xlv_TEXCOORD4;
  mediump float tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * (2.0 * tmpvar_15.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((tmpvar_9 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD4;
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
  normal_5 = xlv_TEXCOORD4;
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
  normal_13 = xlv_TEXCOORD4;
  mediump float tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * (2.0 * tmpvar_15.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 21 math
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
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float3 lightDirection_4;
  float4 tmpvar_5;
  float4 tmpvar_6;
  float tmpvar_7;
  float3 tmpvar_8;
  tmpvar_8 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - _mtl_u._WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = float4(tmpvar_1);
  tmpvar_6.xyz = tmpvar_2;
  half3 tmpvar_13;
  tmpvar_13 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_4 = float3(tmpvar_13);
  float tmpvar_14;
  tmpvar_14 = dot (tmpvar_12, lightDirection_4);
  NdotL_3 = half(tmpvar_14);
  half tmpvar_15;
  tmpvar_15 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_15);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_12;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((tmpvar_8 - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 28 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
def c14, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c14.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c14.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o4.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
dp4 r0.w, v0, c7
mul_sat r0.x, -r1.w, c14.y
add r0.y, r0, c14.w
mad o6.x, r0, r0.y, c15
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.w, r0, c11
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o7.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o5.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedobfahlccnlmpiijfafbffgkhhdcakgebabaaaaaaoeahaaaaadaaaaaa
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
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
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
aaaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
adaaaaaaegiocaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
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
// Stats: 28 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
  mediump float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD2.z > 0.0)
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
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * (2.0 * tmpvar_20.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 28 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
  mediump float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD2.z > 0.0)
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
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * (2.0 * tmpvar_20.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 28 math, 2 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_LightTextureB0, vec2(tmpvar_6));
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
  mediump float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD2.z > 0.0)
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
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * (2.0 * tmpvar_20.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 224
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
Matrix 160 [_LightMatrix0]
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
  float4 xlv_TEXCOORD2;
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 23 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
def c14, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c14.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c14.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o4.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
mul_sat r0.x, -r1.w, c14.y
add r0.y, r0, c14.w
mad o6.x, r0, r0.y, c15
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o7.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o5.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedoaehlmoahhchelnbdgpnlmacnfbcafifabaaaaaaoeahaaaaadaaaaaa
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
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
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
aaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
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
// Stats: 23 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD4;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * (2.0 * tmpvar_19.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 23 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD4;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * (2.0 * tmpvar_19.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 23 math, 2 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
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
  tmpvar_5 = texture (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_LightTexture0, xlv_TEXCOORD2);
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
  highp vec3 tmpvar_14;
  tmpvar_14 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_13) * (atten_9 * 4.0));
  c_10.xyz = tmpvar_14;
  c_10.w = (tmpvar_13 * (atten_9 * 4.0));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_16;
  lightDir_16 = tmpvar_15;
  mediump vec3 normal_17;
  normal_17 = xlv_TEXCOORD4;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * (2.0 * tmpvar_19.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 224
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
Matrix 160 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7).xyz;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 21 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xy;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
def c14, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c14.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c14.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o4.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
mul_sat r0.x, -r1.w, c14.y
add r0.y, r0, c14.w
mad o6.x, r0, r0.y, c15
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o7.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o5.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednfdjhaoehkpoenbijnldfghlpoblmaogabaaaaaaoeahaaaaadaaaaaa
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
aaagaaaaeaaaabaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
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
aaaaaaaaacaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaa
adaaaaaaegiacaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaa
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
// Stats: 21 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
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
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  mediump vec3 lightDir_5;
  lightDir_5 = tmpvar_3;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD4;
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
  normal_15 = xlv_TEXCOORD4;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * (2.0 * tmpvar_17.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 21 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
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
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  mediump vec3 lightDir_5;
  lightDir_5 = tmpvar_3;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD4;
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
  normal_15 = xlv_TEXCOORD4;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * (2.0 * tmpvar_17.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 21 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_LightTexture0, xlv_TEXCOORD2);
  mediump vec3 lightDir_5;
  lightDir_5 = tmpvar_3;
  mediump vec3 normal_6;
  normal_6 = xlv_TEXCOORD4;
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
  normal_15 = xlv_TEXCOORD4;
  mediump float tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * (2.0 * tmpvar_17.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 224
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [_Object2World]
Matrix 160 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float3 lightDirection_4;
  float4 tmpvar_5;
  float4 tmpvar_6;
  float tmpvar_7;
  float4 cse_8;
  cse_8 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = float4(tmpvar_1);
  tmpvar_6.xyz = tmpvar_2;
  half3 tmpvar_13;
  tmpvar_13 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_4 = float3(tmpvar_13);
  float tmpvar_14;
  tmpvar_14 = dot (tmpvar_12, lightDirection_4);
  NdotL_3 = half(tmpvar_14);
  half tmpvar_15;
  tmpvar_15 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_15);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_8).xy;
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_12;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_8.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 32 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  float tmpvar_5;
  if ((tmpvar_4.x < (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))) {
    tmpvar_5 = _LightShadowData.x;
  } else {
    tmpvar_5 = 1.0;
  };
  float atten_6;
  atten_6 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * tmpvar_2.w) * tmpvar_3.w) * tmpvar_5);
  vec4 c_7;
  float tmpvar_8;
  tmpvar_8 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 4.0));
  c_7.w = (tmpvar_8 * (atten_6 * 4.0));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_10;
  tmpvar_10 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_9))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_9))
  , 0.0, 1.0)));
  color_1.w = tmpvar_10.w;
  color_1.xyz = (tmpvar_10.xyz * (2.0 * tmpvar_10.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 46 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c17, c17
rsq r0.x, r0.x
mov r0.w, c18.x
mul r0.xyz, r0.x, c17
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
add r2.w, r1, c18.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c10
dp4 r0.w, v0, c11
mul_sat r0.x, -r1.w, c18.y
add r0.y, r0, c18.w
mad o7.x, r0, r0.y, c19
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.w, r0, c15
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o4.w, r0, c7
dp4 o4.z, r0, c6
dp4 o4.y, r0, c5
dp4 o4.x, r0, c4
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
// Stats: 32 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  highp float tmpvar_11;
  if ((tmpvar_10.x < (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_9 = tmpvar_11;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD4;
  mediump float atten_14;
  atten_14 = (((
    float((xlv_TEXCOORD2.z > 0.0))
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
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * (2.0 * tmpvar_24.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 32 math, 3 textures, 1 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NONATIVE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  highp float tmpvar_11;
  if ((tmpvar_10.x < (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_9 = tmpvar_11;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD4;
  mediump float atten_14;
  atten_14 = (((
    float((xlv_TEXCOORD2.z > 0.0))
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
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * (2.0 * tmpvar_24.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 32 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 46 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c17, c17
rsq r0.x, r0.x
mov r0.w, c18.x
mul r0.xyz, r0.x, c17
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
add r2.w, r1, c18.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c10
dp4 r0.w, v0, c11
mul_sat r0.x, -r1.w, c18.y
add r0.y, r0, c18.w
mad o7.x, r0, r0.y, c19
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.w, r0, c15
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o4.w, r0, c7
dp4 o4.z, r0, c6
dp4 o4.y, r0, c5
dp4 o4.x, r0, c4
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedhcbffcpagcnmiddadgnhdgfeleebmjgpabaaaaaalaaiaaaaadaaaaaa
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
knabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
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
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaa
aeaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
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
// Stats: 32 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DProjEXT (_ShadowMapTexture, xlv_TEXCOORD3);
  mediump float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  tmpvar_8 = shadow_9;
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
  highp vec3 tmpvar_20;
  tmpvar_20 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_19) * (atten_15 * 4.0));
  c_16.xyz = tmpvar_20;
  c_16.w = (tmpvar_19 * (atten_15 * 4.0));
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_22;
  lightDir_22 = tmpvar_21;
  mediump vec3 normal_23;
  normal_23 = xlv_TEXCOORD4;
  mediump float tmpvar_24;
  tmpvar_24 = dot (normal_23, lightDir_22);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (c_16 * mix (1.0, clamp (
    floor((1.01 + tmpvar_24))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_24))
  , 0.0, 1.0)));
  color_2.w = tmpvar_25.w;
  color_2.xyz = (tmpvar_25.xyz * (2.0 * tmpvar_25.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 32 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
in highp vec4 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = textureProj (_ShadowMapTexture, xlv_TEXCOORD3);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  tmpvar_8 = shadow_9;
  mediump vec3 lightDir_12;
  lightDir_12 = tmpvar_3;
  mediump vec3 normal_13;
  normal_13 = xlv_TEXCOORD4;
  mediump float atten_14;
  atten_14 = (((
    float((xlv_TEXCOORD2.z > 0.0))
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
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * (2.0 * tmpvar_24.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 480
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [_Object2World]
Matrix 416 [_LightMatrix0]
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
  float4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7);
  _mtl_o.xlv_TEXCOORD3 = (_mtl_u.unity_World2Shadow[0] * cse_7);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 21 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
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
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec3 tmpvar_7;
  tmpvar_7 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_8)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_8)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
def c12, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c13, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c11, c11
rsq r0.x, r0.x
mul r1.xyz, r0.x, c11
mov r1.w, c12.x
mov r0.xy, v3
mov r0.z, v4.x
dp3 r0.w, -r0, r1
mov r1.xyz, v2
add r2.w, r0, c12.z
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
dp3 r1.x, r2, r2
rsq r1.x, r1.x
mul o4.xyz, r1.x, r2
frc r1.y, r2.w
add_sat r1.y, r2.w, -r1
add r1.z, r1.y, c12.w
mul_sat r0.w, -r0, c12.y
mad o6.x, r0.w, r1.z, c13.y
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c13.x
mul r2.y, r2, c9.x
mad o3.xy, r2.z, c10.zwzw, r2
dp4 r2.z, v0, c6
dp4 r2.x, v0, c4
dp4 r2.y, v0, c5
add r2.xyz, -r2, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov o0, r1
mov o1, v1
mov o3.zw, r1
mul o7.xyz, r0.w, -r2
mov o2.xyz, v2
rcp o2.w, r0.w
mov o5.xyz, -r0
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
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerCamera" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
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
// Stats: 25 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
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
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  mediump vec3 lightDir_10;
  lightDir_10 = tmpvar_3;
  mediump vec3 normal_11;
  normal_11 = xlv_TEXCOORD4;
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
  normal_20 = xlv_TEXCOORD4;
  mediump float tmpvar_21;
  tmpvar_21 = dot (normal_20, lightDir_19);
  mediump vec4 tmpvar_22;
  tmpvar_22 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_21))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_21))
  , 0.0, 1.0)));
  color_2.w = tmpvar_22.w;
  color_2.xyz = (tmpvar_22.xyz * (2.0 * tmpvar_22.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 25 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
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
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  mediump vec3 lightDir_10;
  lightDir_10 = tmpvar_3;
  mediump vec3 normal_11;
  normal_11 = xlv_TEXCOORD4;
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
  normal_20 = xlv_TEXCOORD4;
  mediump float tmpvar_21;
  tmpvar_21 = dot (normal_20, lightDir_19);
  mediump vec4 tmpvar_22;
  tmpvar_22 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_21))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_21))
  , 0.0, 1.0)));
  color_2.w = tmpvar_22.w;
  color_2.xyz = (tmpvar_22.xyz * (2.0 * tmpvar_22.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 22 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
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
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (cse_3.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_4, tmpvar_4));
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = gl_Normal;
  vec4 tmpvar_6;
  tmpvar_6.xy = gl_MultiTexCoord0.xy;
  tmpvar_6.z = gl_MultiTexCoord1.x;
  tmpvar_6.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_7;
  tmpvar_7 = -(tmpvar_6.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, normalize(_WorldSpaceLightPos0.xyz));
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_3).xy;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_8)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_8)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_3.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_6;
  tmpvar_6 = (c_3 * mix (1.0, clamp (
    floor((1.01 + tmpvar_5))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_5))
  , 0.0, 1.0)));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * (2.0 * tmpvar_6.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 45 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c16, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c15, c15
rsq r0.x, r0.x
mov r0.w, c16.x
dp4 r3.w, v0, c3
dp4 r3.z, v0, c2
mul r0.xyz, r0.x, c15
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
dp3 r0.x, r2, r2
add r2.w, r1, c16.z
rsq r0.x, r0.x
frc r0.y, r2.w
mul o5.xyz, r0.x, r2
add_sat r0.y, r2.w, -r0
add r2.x, r0.y, c16.w
mul_sat r0.w, -r1, c16.y
mad o7.x, r0.w, r2, c17.y
dp4 r3.x, v0, c0
dp4 r3.y, v0, c1
mul r0.xyz, r3.xyww, c17.x
mul r0.y, r0, c13.x
mad o4.xy, r0.z, c14.zwzw, r0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp4 o3.y, r0, c9
dp3 r1.w, r2, r2
dp4 o3.x, r0, c8
rsq r0.x, r1.w
mov o0, r3
mov o1, v1
mov o4.zw, r3
mul o8.xyz, r0.x, -r2
mov o2.xyz, v2
rcp o2.w, r0.x
mov o6.xyz, -r1
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
ConstBuffer "$Globals" 368
Matrix 80 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlfagacnmilpllbdgckapfjlegiookjciabaaaaaajeaiaaaaadaaaaaa
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
kgabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
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
diaaaaaidcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaagaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaa
egaabaaaacaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaahaaaaaa
kgakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaakdccabaaaadaaaaaaegiacaaa
aaaaaaaaaiaaaaaapgapbaaaabaaaaaaegaabaaaabaaaaaabaaaaaajbcaabaaa
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
// Stats: 26 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD4;
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
  normal_21 = xlv_TEXCOORD4;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * (2.0 * tmpvar_23.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 26 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = tmpvar_3;
  mediump vec3 normal_12;
  normal_12 = xlv_TEXCOORD4;
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
  normal_21 = xlv_TEXCOORD4;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * (2.0 * tmpvar_23.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 30 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xyz;
  xlv_TEXCOORD3 = (cse_2.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  float tmpvar_3;
  tmpvar_3 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  float tmpvar_4;
  tmpvar_4 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD3), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
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
  tmpvar_8 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_7.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 4.0));
  c_7.w = (tmpvar_8 * (atten_6 * 4.0));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_10;
  tmpvar_10 = (c_7 * mix (1.0, clamp (
    floor((1.01 + tmpvar_9))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_9))
  , 0.0, 1.0)));
  color_1.w = tmpvar_10.w;
  color_1.xyz = (tmpvar_10.xyz * (2.0 * tmpvar_10.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [_LightPositionRange]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c15, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c15.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c15.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
mul_sat r0.x, -r1.w, c15.y
add r0.y, r0, c15.w
mad o7.x, r0, r0.y, c16
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
add o4.xyz, r0, -c14
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedgkcnbnhclafdebmclaekemekpbnikdckabaaaaaacmaiaaaaadaaaaaa
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
imabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaa
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
// Stats: 30 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_ShadowMapTexture, xlv_TEXCOORD3);
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
  normal_12 = xlv_TEXCOORD4;
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
  normal_21 = xlv_TEXCOORD4;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * (2.0 * tmpvar_23.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 30 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_ShadowMapTexture, xlv_TEXCOORD3);
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
  normal_12 = xlv_TEXCOORD4;
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
  normal_21 = xlv_TEXCOORD4;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * (2.0 * tmpvar_23.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 30 math, 2 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
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
  tmpvar_5 = texture (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ShadowMapTexture, xlv_TEXCOORD3);
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
  normal_12 = xlv_TEXCOORD4;
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
  normal_21 = xlv_TEXCOORD4;
  mediump float tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  mediump vec4 tmpvar_23;
  tmpvar_23 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_22))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_22))
  , 0.0, 1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * (2.0 * tmpvar_23.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 240
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
Matrix 176 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7).xyz;
  _mtl_o.xlv_TEXCOORD3 = (cse_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xyz;
  xlv_TEXCOORD3 = (cse_2.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  float tmpvar_4;
  tmpvar_4 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  float tmpvar_5;
  tmpvar_5 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD3), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
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
  tmpvar_9 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_8.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_7 * 4.0));
  c_8.w = (tmpvar_9 * (atten_7 * 4.0));
  float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_11;
  tmpvar_11 = (c_8 * mix (1.0, clamp (
    floor((1.01 + tmpvar_10))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_10))
  , 0.0, 1.0)));
  color_1.w = tmpvar_11.w;
  color_1.xyz = (tmpvar_11.xyz * (2.0 * tmpvar_11.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [_LightPositionRange]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c15, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c15.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c15.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
mul_sat r0.x, -r1.w, c15.y
add r0.y, r0, c15.w
mad o7.x, r0, r0.y, c16
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
add o4.xyz, r0, -c14
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedgkcnbnhclafdebmclaekemekpbnikdckabaaaaaacmaiaaaaadaaaaaa
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
imabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaa
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
// Stats: 31 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD3);
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
  normal_13 = xlv_TEXCOORD4;
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
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * (2.0 * tmpvar_24.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD3);
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
  normal_13 = xlv_TEXCOORD4;
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
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * (2.0 * tmpvar_24.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 31 math, 3 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
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
  tmpvar_5 = texture (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_LightTexture0, xlv_TEXCOORD2);
  highp float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ShadowMapTexture, xlv_TEXCOORD3);
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
  normal_13 = xlv_TEXCOORD4;
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
  normal_22 = xlv_TEXCOORD4;
  mediump float tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  mediump vec4 tmpvar_24;
  tmpvar_24 = (c_15 * mix (1.0, clamp (
    floor((1.01 + tmpvar_23))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_23))
  , 0.0, 1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * (2.0 * tmpvar_24.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 240
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
Matrix 176 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7).xyz;
  _mtl_o.xlv_TEXCOORD3 = (cse_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 40 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 color_1;
  color_1 = _Color;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LightTexture0, ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz)));
  vec4 shadowVals_4;
  vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
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
    float((xlv_TEXCOORD2.z > 0.0))
   * tmpvar_2.w) * tmpvar_3.w) * dot (tmpvar_12, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_14;
  float tmpvar_15;
  tmpvar_15 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_14.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_15) * (atten_13 * 4.0));
  c_14.w = (tmpvar_15 * (atten_13 * 4.0));
  float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_17;
  tmpvar_17 = (c_14 * mix (1.0, clamp (
    floor((1.01 + tmpvar_16))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_16))
  , 0.0, 1.0)));
  color_1.w = tmpvar_17.w;
  color_1.xyz = (tmpvar_17.xyz * (2.0 * tmpvar_17.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 46 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c17, c17
rsq r0.x, r0.x
mov r0.w, c18.x
mul r0.xyz, r0.x, c17
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
add r2.w, r1, c18.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c10
dp4 r0.w, v0, c11
mul_sat r0.x, -r1.w, c18.y
add r0.y, r0, c18.w
mad o7.x, r0, r0.y, c19
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.w, r0, c15
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o4.w, r0, c7
dp4 o4.z, r0, c6
dp4 o4.y, r0, c5
dp4 o4.x, r0, c4
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
// Stats: 40 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  highp vec4 shadowVals_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
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
  normal_28 = xlv_TEXCOORD4;
  mediump float atten_29;
  atten_29 = (((
    float((xlv_TEXCOORD2.z > 0.0))
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
  normal_37 = xlv_TEXCOORD4;
  mediump float tmpvar_38;
  tmpvar_38 = dot (normal_37, lightDir_36);
  mediump vec4 tmpvar_39;
  tmpvar_39 = (c_30 * mix (1.0, clamp (
    floor((1.01 + tmpvar_38))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_38))
  , 0.0, 1.0)));
  color_2.w = tmpvar_39.w;
  color_2.xyz = (tmpvar_39.xyz * (2.0 * tmpvar_39.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 40 math, 6 textures, 4 branches
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NONATIVE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  highp vec4 shadowVals_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
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
  normal_28 = xlv_TEXCOORD4;
  mediump float atten_29;
  atten_29 = (((
    float((xlv_TEXCOORD2.z > 0.0))
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
  normal_37 = xlv_TEXCOORD4;
  mediump float tmpvar_38;
  tmpvar_38 = dot (normal_37, lightDir_36);
  mediump vec4 tmpvar_39;
  tmpvar_39 = (c_30 * mix (1.0, clamp (
    floor((1.01 + tmpvar_38))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_38))
  , 0.0, 1.0)));
  color_2.w = tmpvar_39.w;
  color_2.xyz = (tmpvar_39.xyz * (2.0 * tmpvar_39.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 38 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  vec4 tmpvar_4;
  tmpvar_4 = (_LightShadowData.xxxx + (shadows_2 * (1.0 - _LightShadowData.xxxx)));
  shadows_2 = tmpvar_4;
  float atten_5;
  atten_5 = (((
    float((xlv_TEXCOORD2.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz))).w) * dot (tmpvar_4, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_6;
  float tmpvar_7;
  tmpvar_7 = dot (normalize(xlv_TEXCOORD4), normalize(_WorldSpaceLightPos0.xyz));
  c_6.xyz = (((_Color.xyz * _LightColor0.xyz) * tmpvar_7) * (atten_5 * 4.0));
  c_6.w = (tmpvar_7 * (atten_5 * 4.0));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD4, normalize(_WorldSpaceLightPos0).xyz);
  vec4 tmpvar_9;
  tmpvar_9 = (c_6 * mix (1.0, clamp (
    floor((1.01 + tmpvar_8))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_8))
  , 0.0, 1.0)));
  color_1.w = tmpvar_9.w;
  color_1.xyz = (tmpvar_9.xyz * (2.0 * tmpvar_9.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 46 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c17, c17
rsq r0.x, r0.x
mov r0.w, c18.x
mul r0.xyz, r0.x, c17
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
add r2.w, r1, c18.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c10
dp4 r0.w, v0, c11
mul_sat r0.x, -r1.w, c18.y
add r0.y, r0, c18.w
mad o7.x, r0, r0.y, c19
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.w, r0, c15
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o4.w, r0, c7
dp4 o4.z, r0, c6
dp4 o4.y, r0, c5
dp4 o4.x, r0, c4
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 368
Matrix 80 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedkkngddnemjhmkfcikkfenbkmaialpanjabaaaaaalaaiaaaaadaaaaaa
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
knabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
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
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaagaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaa
aiaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
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
// Stats: 38 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture2D (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump vec4 shadows_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
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
  highp vec3 tmpvar_28;
  tmpvar_28 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_27) * (atten_23 * 4.0));
  c_24.xyz = tmpvar_28;
  c_24.w = (tmpvar_27 * (atten_23 * 4.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_29;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD4;
  mediump float tmpvar_32;
  tmpvar_32 = dot (normal_31, lightDir_30);
  mediump vec4 tmpvar_33;
  tmpvar_33 = (c_24 * mix (1.0, clamp (
    floor((1.01 + tmpvar_32))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_32))
  , 0.0, 1.0)));
  color_2.w = tmpvar_33.w;
  color_2.xyz = (tmpvar_33.xyz * (2.0 * tmpvar_33.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 38 math, 6 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
in highp vec4 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  highp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = texture (_LightTexture0, P_5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_LightTextureB0, vec2(tmpvar_6));
  lowp float tmpvar_8;
  mediump vec4 shadows_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
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
  highp vec3 tmpvar_28;
  tmpvar_28 = (((color_2.xyz * _LightColor0.xyz) * tmpvar_27) * (atten_23 * 4.0));
  c_24.xyz = tmpvar_28;
  c_24.w = (tmpvar_27 * (atten_23 * 4.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = tmpvar_29;
  mediump vec3 normal_31;
  normal_31 = xlv_TEXCOORD4;
  mediump float tmpvar_32;
  tmpvar_32 = dot (normal_31, lightDir_30);
  mediump vec4 tmpvar_33;
  tmpvar_33 = (c_24 * mix (1.0, clamp (
    floor((1.01 + tmpvar_32))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_32))
  , 0.0, 1.0)));
  color_2.w = tmpvar_33.w;
  color_2.xyz = (tmpvar_33.xyz * (2.0 * tmpvar_33.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 480
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [_Object2World]
Matrix 416 [_LightMatrix0]
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
  float4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7);
  _mtl_o.xlv_TEXCOORD3 = (_mtl_u.unity_World2Shadow[0] * cse_7);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 41 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xyz;
  xlv_TEXCOORD3 = (cse_2.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  shadowVals_3.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_3.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_3.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_3.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
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
  vec4 tmpvar_15;
  tmpvar_15 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_14))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_14))
  , 0.0, 1.0)));
  color_1.w = tmpvar_15.w;
  color_1.xyz = (tmpvar_15.xyz * (2.0 * tmpvar_15.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [_LightPositionRange]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c15, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c15.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c15.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
mul_sat r0.x, -r1.w, c15.y
add r0.y, r0, c15.w
mad o7.x, r0, r0.y, c16
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
add o4.xyz, r0, -c14
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedgkcnbnhclafdebmclaekemekpbnikdckabaaaaaacmaiaaaaadaaaaaa
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
imabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaa
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
// Stats: 41 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_6;
  highp vec4 shadowVals_7;
  highp float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, vec_9);
  packDist_10 = tmpvar_11;
  shadowVals_7.x = dot (packDist_10, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_12;
  vec_12 = (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureCube (_ShadowMapTexture, vec_12);
  packDist_13 = tmpvar_14;
  shadowVals_7.y = dot (packDist_13, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_15;
  vec_15 = (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureCube (_ShadowMapTexture, vec_15);
  packDist_16 = tmpvar_17;
  shadowVals_7.z = dot (packDist_16, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125));
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
  normal_30 = xlv_TEXCOORD4;
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
  normal_39 = xlv_TEXCOORD4;
  mediump float tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (c_32 * mix (1.0, clamp (
    floor((1.01 + tmpvar_40))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_40))
  , 0.0, 1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * (2.0 * tmpvar_41.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 41 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_6;
  highp vec4 shadowVals_7;
  highp float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, vec_9);
  packDist_10 = tmpvar_11;
  shadowVals_7.x = dot (packDist_10, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_12;
  vec_12 = (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureCube (_ShadowMapTexture, vec_12);
  packDist_13 = tmpvar_14;
  shadowVals_7.y = dot (packDist_13, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_15;
  vec_15 = (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureCube (_ShadowMapTexture, vec_15);
  packDist_16 = tmpvar_17;
  shadowVals_7.z = dot (packDist_16, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125));
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
  normal_30 = xlv_TEXCOORD4;
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
  normal_39 = xlv_TEXCOORD4;
  mediump float tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (c_32 * mix (1.0, clamp (
    floor((1.01 + tmpvar_40))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_40))
  , 0.0, 1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * (2.0 * tmpvar_41.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 41 math, 5 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
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
  tmpvar_5 = texture (_LightTexture0, vec2(tmpvar_4));
  highp float tmpvar_6;
  highp vec4 shadowVals_7;
  highp float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, vec_9);
  packDist_10 = tmpvar_11;
  shadowVals_7.x = dot (packDist_10, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_12;
  vec_12 = (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_ShadowMapTexture, vec_12);
  packDist_13 = tmpvar_14;
  shadowVals_7.y = dot (packDist_13, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_15;
  vec_15 = (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture (_ShadowMapTexture, vec_15);
  packDist_16 = tmpvar_17;
  shadowVals_7.z = dot (packDist_16, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125));
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
  normal_30 = xlv_TEXCOORD4;
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
  normal_39 = xlv_TEXCOORD4;
  mediump float tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (c_32 * mix (1.0, clamp (
    floor((1.01 + tmpvar_40))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_40))
  , 0.0, 1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * (2.0 * tmpvar_41.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 240
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
Matrix 176 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7).xyz;
  _mtl_o.xlv_TEXCOORD3 = (cse_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 42 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
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
  vec4 cse_2;
  cse_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (cse_2.xyz - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (tmpvar_3, tmpvar_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.xy = gl_MultiTexCoord0.xy;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_WorldSpaceLightPos0.xyz));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_2).xyz;
  xlv_TEXCOORD3 = (cse_2.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor(
    (1.01 + tmpvar_7)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(tmpvar_7)
  ), 0.0, 1.0));
  xlv_TEXCOORD7 = normalize((cse_2.xyz - _WorldSpaceCameraPos));
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
  shadowVals_4.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_4.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_4.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  shadowVals_4.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
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
  vec4 tmpvar_16;
  tmpvar_16 = (c_13 * mix (1.0, clamp (
    floor((1.01 + tmpvar_15))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_15))
  , 0.0, 1.0)));
  color_1.w = tmpvar_16.w;
  color_1.xyz = (tmpvar_16.xyz * (2.0 * tmpvar_16.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [_LightPositionRange]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c15, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c13, c13
rsq r0.x, r0.x
mov r0.w, c15.x
mul r0.xyz, r0.x, c13
mov r1.xy, v3
mov r1.z, v4.x
dp3 r1.w, -r1, r0
mov r0.xyz, v2
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
add r2.w, r1, c15.z
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul o5.xyz, r0.x, r2
frc r0.y, r2.w
add_sat r0.y, r2.w, -r0
dp4 r0.z, v0, c6
mul_sat r0.x, -r1.w, c15.y
add r0.y, r0, c15.w
mad o7.x, r0, r0.y, c16
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o1, v1
dp4 o3.z, r0, c10
dp4 o3.y, r0, c9
dp4 o3.x, r0, c8
mul o8.xyz, r1.w, -r2
mov o2.xyz, v2
rcp o2.w, r1.w
add o4.xyz, r0, -c14
mov o6.xyz, -r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
ConstBuffer "$Globals" 304
Matrix 16 [_LightMatrix0]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedgkcnbnhclafdebmclaekemekpbnikdckabaaaaaacmaiaaaaadaaaaaa
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
imabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaa
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
// Stats: 42 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_7;
  highp vec4 shadowVals_8;
  highp float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_ShadowMapTexture, vec_10);
  packDist_11 = tmpvar_12;
  shadowVals_8.x = dot (packDist_11, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_13;
  vec_13 = (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_ShadowMapTexture, vec_13);
  packDist_14 = tmpvar_15;
  shadowVals_8.y = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_16;
  vec_16 = (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_ShadowMapTexture, vec_16);
  packDist_17 = tmpvar_18;
  shadowVals_8.z = dot (packDist_17, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_19;
  vec_19 = (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125));
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
  normal_31 = xlv_TEXCOORD4;
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
  normal_40 = xlv_TEXCOORD4;
  mediump float tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (c_33 * mix (1.0, clamp (
    floor((1.01 + tmpvar_41))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_41))
  , 0.0, 1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * (2.0 * tmpvar_42.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 42 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


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
uniform highp mat4 _LightMatrix0;
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
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
  highp float tmpvar_7;
  highp vec4 shadowVals_8;
  highp float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_ShadowMapTexture, vec_10);
  packDist_11 = tmpvar_12;
  shadowVals_8.x = dot (packDist_11, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_13;
  vec_13 = (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_ShadowMapTexture, vec_13);
  packDist_14 = tmpvar_15;
  shadowVals_8.y = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_16;
  vec_16 = (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_ShadowMapTexture, vec_16);
  packDist_17 = tmpvar_18;
  shadowVals_8.z = dot (packDist_17, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_19;
  vec_19 = (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125));
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
  normal_31 = xlv_TEXCOORD4;
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
  normal_40 = xlv_TEXCOORD4;
  mediump float tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (c_33 * mix (1.0, clamp (
    floor((1.01 + tmpvar_41))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_41))
  , 0.0, 1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * (2.0 * tmpvar_42.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 42 math, 6 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.xy = _glesMultiTexCoord0.xy;
  tmpvar_11.z = tmpvar_3.x;
  tmpvar_11.w = tmpvar_3.y;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = tmpvar_1;
  tmpvar_6.xyz = tmpvar_2;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, normalize(_WorldSpaceLightPos0.xyz));
  NdotL_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_7 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_8).xyz;
  xlv_TEXCOORD3 = (cse_8.xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_10).xyz);
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = normalize((cse_8.xyz - _WorldSpaceCameraPos));
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
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
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
  tmpvar_5 = texture (_LightTextureB0, vec2(tmpvar_4));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_LightTexture0, xlv_TEXCOORD2);
  highp float tmpvar_7;
  highp vec4 shadowVals_8;
  highp float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD3 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_ShadowMapTexture, vec_10);
  packDist_11 = tmpvar_12;
  shadowVals_8.x = dot (packDist_11, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_13;
  vec_13 = (xlv_TEXCOORD3 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture (_ShadowMapTexture, vec_13);
  packDist_14 = tmpvar_15;
  shadowVals_8.y = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_16;
  vec_16 = (xlv_TEXCOORD3 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, vec_16);
  packDist_17 = tmpvar_18;
  shadowVals_8.z = dot (packDist_17, vec4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  highp vec3 vec_19;
  vec_19 = (xlv_TEXCOORD3 + vec3(0.0078125, -0.0078125, -0.0078125));
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
  normal_31 = xlv_TEXCOORD4;
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
  normal_40 = xlv_TEXCOORD4;
  mediump float tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (c_33 * mix (1.0, clamp (
    floor((1.01 + tmpvar_41))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_41))
  , 0.0, 1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * (2.0 * tmpvar_42.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 240
Matrix 48 [glstate_matrix_mvp]
Matrix 112 [_Object2World]
Matrix 176 [_LightMatrix0]
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
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float4 tmpvar_4;
  float4 tmpvar_5;
  float tmpvar_6;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_8;
  tmpvar_8 = (cse_7.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_5.w = sqrt(dot (tmpvar_8, tmpvar_8));
  float4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_2;
  float4 tmpvar_10;
  tmpvar_10.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_10.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_10.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_11;
  tmpvar_11 = -(tmpvar_10.xyz);
  tmpvar_4 = float4(tmpvar_1);
  tmpvar_5.xyz = tmpvar_2;
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, normalize(_mtl_u._WorldSpaceLightPos0.xyz));
  NdotL_3 = half(tmpvar_12);
  half tmpvar_13;
  tmpvar_13 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_6 = float(tmpvar_13);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_7).xyz;
  _mtl_o.xlv_TEXCOORD3 = (cse_7.xyz - _mtl_u._LightPositionRange.xyz);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_9).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_7.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  mediump vec3 lightDir_7;
  lightDir_7 = tmpvar_3;
  mediump vec3 normal_8;
  normal_8 = xlv_TEXCOORD4;
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
  normal_17 = xlv_TEXCOORD4;
  mediump float tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  mediump vec4 tmpvar_19;
  tmpvar_19 = (c_10 * mix (1.0, clamp (
    floor((1.01 + tmpvar_18))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_18))
  , 0.0, 1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * (2.0 * tmpvar_19.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 24 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
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
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * (2.0 * tmpvar_20.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 416
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [_Object2World]
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
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  half4 _WorldSpaceLightPos0;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float3 lightDirection_4;
  float4 tmpvar_5;
  float4 tmpvar_6;
  float tmpvar_7;
  float4 cse_8;
  cse_8 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = float4(tmpvar_1);
  tmpvar_6.xyz = tmpvar_2;
  half3 tmpvar_13;
  tmpvar_13 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_4 = float3(tmpvar_13);
  float tmpvar_14;
  tmpvar_14 = dot (tmpvar_12, lightDirection_4);
  NdotL_3 = half(tmpvar_14);
  half tmpvar_15;
  tmpvar_15 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_15);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_8);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_12;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_8.xyz - _mtl_u._WorldSpaceCameraPos));
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
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
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD2);
  lowp float shadow_5;
  lowp float tmpvar_6;
  tmpvar_6 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_7;
  mediump vec3 lightDir_8;
  lightDir_8 = tmpvar_3;
  mediump vec3 normal_9;
  normal_9 = xlv_TEXCOORD4;
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
  normal_18 = xlv_TEXCOORD4;
  mediump float tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  mediump vec4 tmpvar_20;
  tmpvar_20 = (c_11 * mix (1.0, clamp (
    floor((1.01 + tmpvar_19))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_19))
  , 0.0, 1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * (2.0 * tmpvar_20.w));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 25 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1;
  mediump float NdotL_4;
  highp vec3 lightDirection_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = (cse_9.xyz - _WorldSpaceCameraPos);
  tmpvar_7.w = sqrt(dot (tmpvar_10, tmpvar_10));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.xy = _glesMultiTexCoord0.xy;
  tmpvar_12.z = tmpvar_3.x;
  tmpvar_12.w = tmpvar_3.y;
  highp vec3 tmpvar_13;
  tmpvar_13 = -(tmpvar_12.xyz);
  tmpvar_6 = tmpvar_1;
  tmpvar_7.xyz = tmpvar_2;
  lowp vec3 tmpvar_14;
  tmpvar_14 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_13, lightDirection_5);
  NdotL_4 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = mix (1.0, clamp (floor(
    (1.01 + NdotL_4)
  ), 0.0, 1.0), clamp ((10.0 * 
    -(NdotL_4)
  ), 0.0, 1.0));
  tmpvar_8 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = (_LightMatrix0 * cse_9).xy;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_11).xyz);
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = normalize((cse_9.xyz - _WorldSpaceCameraPos));
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
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2 = _Color;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_LightTexture0, xlv_TEXCOORD2);
  lowp float shadow_5;
  mediump float tmpvar_6;
  tmpvar_6 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_8;
  mediump vec3 lightDir_9;
  lightDir_9 = tmpvar_3;
  mediump vec3 normal_10;
  normal_10 = xlv_TEXCOORD4;
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
  normal_19 = xlv_TEXCOORD4;
  mediump float tmpvar_20;
  tmpvar_20 = dot (normal_19, lightDir_18);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (c_12 * mix (1.0, clamp (
    floor((1.01 + tmpvar_20))
  , 0.0, 1.0), clamp (
    (10.0 * -(tmpvar_20))
  , 0.0, 1.0)));
  color_2.w = tmpvar_21.w;
  color_2.xyz = (tmpvar_21.xyz * (2.0 * tmpvar_21.w));
  tmpvar_1 = color_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 23 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
Bind "texcoord1" ATTR4
ConstBuffer "$Globals" 480
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [_Object2World]
Matrix 416 [_LightMatrix0]
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
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
  float xlv_TEXCOORD6;
  float3 xlv_TEXCOORD7;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  half4 _WorldSpaceLightPos0;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _LightMatrix0;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float3 tmpvar_2;
  tmpvar_2 = normalize(_mtl_i._glesNormal);
  half NdotL_3;
  float3 lightDirection_4;
  float4 tmpvar_5;
  float4 tmpvar_6;
  float tmpvar_7;
  float4 cse_8;
  cse_8 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_9;
  tmpvar_9 = (cse_8.xyz - _mtl_u._WorldSpaceCameraPos);
  tmpvar_6.w = sqrt(dot (tmpvar_9, tmpvar_9));
  float4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_2;
  float4 tmpvar_11;
  tmpvar_11.xy = _mtl_i._glesMultiTexCoord0.xy;
  tmpvar_11.z = _mtl_i._glesMultiTexCoord1.x;
  tmpvar_11.w = _mtl_i._glesMultiTexCoord1.y;
  float3 tmpvar_12;
  tmpvar_12 = -(tmpvar_11.xyz);
  tmpvar_5 = float4(tmpvar_1);
  tmpvar_6.xyz = tmpvar_2;
  half3 tmpvar_13;
  tmpvar_13 = normalize(_mtl_u._WorldSpaceLightPos0.xyz);
  lightDirection_4 = float3(tmpvar_13);
  float tmpvar_14;
  tmpvar_14 = dot (tmpvar_12, lightDirection_4);
  NdotL_3 = half(tmpvar_14);
  half tmpvar_15;
  tmpvar_15 = mix ((half)1.0, clamp (floor(
    ((half)1.01 + NdotL_3)
  ), (half)0.0, (half)1.0), clamp (((half)10.0 * 
    -(NdotL_3)
  ), (half)0.0, (half)1.0));
  tmpvar_7 = float(tmpvar_15);
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._LightMatrix0 * cse_8).xy;
  _mtl_o.xlv_TEXCOORD3 = (_mtl_u.unity_World2Shadow[0] * cse_8);
  _mtl_o.xlv_TEXCOORD4 = normalize((_mtl_u._Object2World * tmpvar_10).xyz);
  _mtl_o.xlv_TEXCOORD5 = tmpvar_12;
  _mtl_o.xlv_TEXCOORD6 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD7 = normalize((cse_8.xyz - _mtl_u._WorldSpaceCameraPos));
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
// Stats: 29 math, 1 textures
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
"ps_3_0
dcl_2d s0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xyz
dcl_texcoord4 v2.xyz
dp3_pp r0.x, c0, c0
rsq_pp r0.w, r0.x
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v2
dp3_pp r0.y, r0, r1
dp4 r0.w, c0, c0
rsq r0.z, r0.w
mul r1.xyz, r0.z, c0
dp3_pp r0.z, v2, r1
add_pp r1.w, r0.z, c3.z
dp3 r0.x, v1, v1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 25 math, 1 textures
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
eefiecedlijmonpcmobmeikdpdfhpnhdhjfioiddabaaaaaamaaeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaadaaaaeaaaaaaanmaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
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
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaa
apaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaeadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
agaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
// Stats: 22 math, 1 textures
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
  float3 tmpvar_13;
  tmpvar_13 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_12) * (atten_8 * (half)4.0)));
  c_9.xyz = half3(tmpvar_13);
  c_9.w = (tmpvar_12 * (atten_8 * (half)4.0));
  float3 tmpvar_14;
  tmpvar_14 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_15;
  lightDir_15 = half3(tmpvar_14);
  half3 normal_16;
  normal_16 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_17;
  tmpvar_17 = dot (normal_16, lightDir_15);
  half4 tmpvar_18;
  tmpvar_18 = (c_9 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_17))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_17))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_18.w;
  color_2.xyz = (tmpvar_18.xyz * ((half)2.0 * tmpvar_18.w));
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
// Stats: 26 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
"ps_3_0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 2.00000000, 0, 0
dcl_texcoord4 v1.xyz
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Vector 176 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedeidcjjelkdonmhhjhfldlkacpdchaogdabaaaaaadaaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiacaaaaeaaaaaaaloaaaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
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
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeadiaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaea
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
aaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 19 math
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
  half3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half3 lightDir_4;
  lightDir_4 = tmpvar_3;
  half3 normal_5;
  normal_5 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_13 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_14;
  tmpvar_14 = dot (normal_13, lightDir_12);
  half4 tmpvar_15;
  tmpvar_15 = (c_6 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_14))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_14))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_15.w;
  color_2.xyz = (tmpvar_15.xyz * ((half)2.0 * tmpvar_15.w));
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
// Stats: 34 math, 2 textures
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
def c4, 10.00000000, 1.00976563, -1.00000000, 2.00000000
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dp3_pp r0.x, c0, c0
rsq_pp r0.w, r0.x
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v2
dp3_pp r0.y, r0, r1
dp4 r0.w, c0, c0
rsq r0.z, r0.w
mul r1.xyz, r0.z, c0
rcp r0.x, v1.w
mad r2.xy, v1, r0.x, c3.x
dp3 r0.x, v1, v1
texld r0.w, r2, s0
cmp r0.z, -v1, c3.y, c3
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s1
mul_pp r0.x, r0.z, r0
dp3_pp r0.z, v2, r1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 31 math, 2 textures
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
eefiecedkjhefbleejbbghfodikilkapmciejkdeabaaaaaaleafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaaiaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgeaeaaaaeaaaaaaabjabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
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
aaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 28 math, 2 textures
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
  float4 xlv_TEXCOORD2;
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
  float2 P_5;
  P_5 = ((_mtl_i.xlv_TEXCOORD2.xy / _mtl_i.xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD2.xyz, _mtl_i.xlv_TEXCOORD2.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_6)));
  half3 lightDir_8;
  lightDir_8 = half3(tmpvar_3);
  half3 normal_9;
  normal_9 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_10;
  atten_10 = half(((float(
    (_mtl_i.xlv_TEXCOORD2.z > 0.0)
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
  normal_18 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  half4 tmpvar_20;
  tmpvar_20 = (c_11 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_19))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_19))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * ((half)2.0 * tmpvar_20.w));
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
// Stats: 30 math, 2 textures
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
def c4, 1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xyz
dcl_texcoord4 v2.xyz
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v2
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4 r1.w, c0, c0
rsq r0.w, r1.w
mul r1.xyz, r0.w, c0
dp3_pp r0.z, v2, r1
add_pp r1.w, r0.z, c3.z
dp3 r0.x, v1, v1
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
add_pp_sat r1.w, r1, -r2.x
texld r0.w, v1, s1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 26 math, 2 textures
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
eefiecedlagnhjdfbpdbfnojaicebhgocjnkajpeabaaaaaabmafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmmadaaaaeaaaaaaapdaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
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
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 23 math, 2 textures
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
  float3 tmpvar_14;
  tmpvar_14 = ((float3)(((color_2.xyz * _mtl_u._LightColor0.xyz) * tmpvar_13) * (atten_9 * (half)4.0)));
  c_10.xyz = half3(tmpvar_14);
  c_10.w = (tmpvar_13 * (atten_9 * (half)4.0));
  float3 tmpvar_15;
  tmpvar_15 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  half3 lightDir_16;
  lightDir_16 = half3(tmpvar_15);
  half3 normal_17;
  normal_17 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_18;
  tmpvar_18 = dot (normal_17, lightDir_16);
  half4 tmpvar_19;
  tmpvar_19 = (c_10 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_18))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_18))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_19.w;
  color_2.xyz = (tmpvar_19.xyz * ((half)2.0 * tmpvar_19.w));
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
// Stats: 28 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_LightTexture0] 2D 0
"ps_3_0
dcl_2d s0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xy
dcl_texcoord4 v2.xyz
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v2
mul_pp r1.xyz, r0.w, c0
dp4_pp r1.w, c0, c0
rsq_pp r0.w, r1.w
mul_pp r2.xyz, r0.w, c0
dp3_pp r1.y, r0, r1
dp3_pp r1.x, v2, r2
add_pp r1.z, r1.x, c3
frc_pp r2.x, r1.z
texld r0.w, v1, s0
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 24 math, 1 textures
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
eefiecedmmifijilloamckhggennlgekbfhjikniabaaaaaakeaeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaeaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaanfaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
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
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaa
apaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiaea
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaagaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
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
// Stats: 21 math, 1 textures
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
  half3 tmpvar_3;
  tmpvar_3 = _mtl_u._WorldSpaceLightPos0.xyz;
  half4 tmpvar_4;
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(_mtl_i.xlv_TEXCOORD2));
  half3 lightDir_5;
  lightDir_5 = tmpvar_3;
  half3 normal_6;
  normal_6 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_15 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_16;
  tmpvar_16 = dot (normal_15, lightDir_14);
  half4 tmpvar_17;
  tmpvar_17 = (c_8 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_16))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_16))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_17.w;
  color_2.xyz = (tmpvar_17.xyz * ((half)2.0 * tmpvar_17.w));
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
// Stats: 39 math, 3 textures
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
def c5, 10.00000000, 1.00976563, -1.00000000, 2.00000000
dcl_texcoord2 v1
dcl_texcoord3 v2
dcl_texcoord4 v3.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v3
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4 r1.w, c0, c0
rsq r0.w, r1.w
mul r1.xyz, r0.w, c0
texldp r0.x, v2, s2
rcp r0.z, v2.w
mad r0.z, -v2, r0, r0.x
mov r0.w, c1.x
rcp r0.x, v1.w
mad r2.xy, v1, r0.x, c4.x
cmp r0.z, r0, c4.y, r0.w
dp3 r0.x, v1, v1
texld r0.w, r2, s0
cmp r1.w, -v1.z, c4.z, c4.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s1
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r0.z
dp3_pp r0.z, v3, r1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c5.w
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
// Stats: 38 math, 3 textures
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
def c5, 10.00000000, 1.00976563, -1.00000000, 2.00000000
dcl_texcoord2 v1
dcl_texcoord3 v2
dcl_texcoord4 v3.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v3
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4 r1.w, c0, c0
rsq r0.w, r1.w
mul r1.xyz, r0.w, c0
mov r0.x, c1
rcp r0.w, v1.w
mad r2.xy, v1, r0.w, c4.x
add r0.z, c4.y, -r0.x
texldp r0.x, v2, s2
mad r0.z, r0.x, r0, c1.x
dp3 r0.x, v1, v1
texld r0.w, r2, s0
cmp r1.w, -v1.z, c4.z, c4.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s1
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r0.z
dp3_pp r0.z, v3, r1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c5.w
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 35 math, 2 textures
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
eefiecedppnjidmffjbhgmahonjpfbheeiijogkhabaaaaaaleagaaaaadaaaaaa
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
fdeieefcemafaaaaeaaaaaaafdabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 32 math, 3 textures
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
  float4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
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
  P_5 = ((_mtl_i.xlv_TEXCOORD2.xy / _mtl_i.xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD2.xyz, _mtl_i.xlv_TEXCOORD2.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_6)));
  half tmpvar_8;
  half shadow_9;
  half tmpvar_10;
  tmpvar_10 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD3).xy / (float)(_mtl_i.xlv_TEXCOORD3).w, (float)(_mtl_i.xlv_TEXCOORD3).z / (float)(_mtl_i.xlv_TEXCOORD3).w);
  float tmpvar_11;
  tmpvar_11 = (_mtl_u._LightShadowData.x + ((float)tmpvar_10 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_9 = half(tmpvar_11);
  tmpvar_8 = shadow_9;
  half3 lightDir_12;
  lightDir_12 = half3(tmpvar_3);
  half3 normal_13;
  normal_13 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_14;
  atten_14 = half((((
    float((_mtl_i.xlv_TEXCOORD2.z > 0.0))
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
  normal_22 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  half4 tmpvar_24;
  tmpvar_24 = (c_15 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_23))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_23))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * ((half)2.0 * tmpvar_24.w));
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
// Stats: 28 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_ShadowMapTexture] 2D 0
"ps_3_0
dcl_2d s0
def c3, 4.00000000, 10.00000000, 1.00976563, -1.00000000
def c4, 1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v2
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.z, r0, r1
dp4_pp r1.w, c0, c0
rsq_pp r0.w, r1.w
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, v2, r1
add_pp r1.w, r0.y, c3.z
texldp r0.x, v1, s0
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 25 math, 1 textures
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
eefiecednmhhegmgnhknhpoibaggldclibpgjiblabaaaaaamaaeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaaiaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaadaaaaeaaaaaaanmaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
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
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaa
apaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
aoaaaaahmcaabaaaaaaaaaaaagbebaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaeadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
agaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
// Stats: 29 math, 2 textures
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
def c4, 1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
dcl_texcoord4 v3.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
dp3_pp r0.w, c0, c0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.x, v3
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.y, r0, r1
dp4_pp r1.w, c0, c0
rsq_pp r0.w, r1.w
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.z, v3, r1
add_pp r1.w, r0.z, c3.z
mov_pp r1.xyz, c2
frc_pp r2.x, r1.w
mul_pp r1.xyz, c1, r1
add_pp_sat r1.w, r1, -r2.x
texld r0.w, v1, s1
texldp r0.x, v2, s0
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 26 math, 2 textures
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
eefiecedlmolehgjbbedenalnkdbgbgapdomkhngabaaaaaaeaafaaaaadaaaaaa
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
fdeieefcniadaaaaeaaaaaaapgaaaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
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
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaa
bdaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
aoaaaaahmcaabaaaaaaaaaaaagbebaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
agaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
// Stats: 38 math, 2 textures
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
def c7, -1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
dcl_texcoord4 v3.xyz
dp3_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
dp3_pp r0.y, v3, v3
mov_pp r2.xyz, c4
mul_pp r1.xyz, r0.x, c0
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v3
dp3_pp r1.w, r0, r1
mul_pp r1.xyz, c3, r2
dp3 r0.x, v2, v2
rsq r2.x, r0.x
texld r0, v2, s0
dp4 r0.y, r0, c5
rcp r2.x, r2.x
mul r0.x, r2, c1.w
mad r0.y, -r0.x, c6.x, r0
mov r0.x, c2
cmp r0.y, r0, c5.x, r0.x
dp4 r0.z, c0, c0
rsq r0.z, r0.z
mul r2.xyz, r0.z, c0
dp3_pp r0.w, v3, r2
add_pp r2.y, r0.w, c6.w
dp3 r0.x, v1, v1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c7.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 32 math, 2 textures
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
eefiecedkogpcajmikpaaalobhndpopchcopjehpabaaaaaaciagaaaaadaaaaaa
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
fdeieefcmaaeaaaaeaaaaaaadaabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
bbaaaaakecaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpibiaiadl
icabibdhafidibdddbaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadhaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaa
biaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiaeabaaaaaajecaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaa
aaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaagaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
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
// Stats: 30 math, 2 textures, 1 branches
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float4 packDist_7;
  half4 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(_mtl_i.xlv_TEXCOORD3));
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
  normal_12 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_21 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_22;
  tmpvar_22 = dot (normal_21, lightDir_20);
  half4 tmpvar_23;
  tmpvar_23 = (c_14 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_22))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_22))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_23.w;
  color_2.xyz = (tmpvar_23.xyz * ((half)2.0 * tmpvar_23.w));
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
// Stats: 39 math, 3 textures
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
def c7, -1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
dcl_texcoord4 v3.xyz
mov_pp r0.xyz, c4
mul_pp r2.xyz, c3, r0
dp3_pp r0.x, c0, c0
rsq_pp r0.x, r0.x
dp3_pp r0.y, v3, v3
mul_pp r1.xyz, r0.x, c0
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v3
dp3_pp r1.w, r0, r1
texld r0, v2, s0
dp4 r0.y, r0, c5
mul_pp r1.xyz, r1.w, r2
dp3 r2.x, v2, v2
rsq r2.x, r2.x
rcp r0.x, r2.x
mul r0.x, r0, c1.w
mad r2.x, -r0, c6, r0.y
dp4 r0.z, c0, c0
mov r0.w, c2.x
cmp r2.x, r2, c5, r0.w
rsq r0.x, r0.z
mul r0.xyz, r0.x, c0
dp3_pp r0.y, v3, r0
dp3 r0.x, v1, v1
texld r0.w, v1, s2
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c7.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 33 math, 3 textures
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
eefiecedepnegbjemeedhfkednocaljpkichakcmabaaaaaaieagaaaaadaaaaaa
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
fdeieefcbmafaaaaeaaaaaaaehabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
abaaaaaaegbcbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaabbaaaaak
ecaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdh
afidibdddbaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dhaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaa
abeaaaaaaaaaiadpbaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaea
baaaaaajecaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahecaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaa
apaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaagaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
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
// Stats: 31 math, 3 textures, 1 branches
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD2));
  float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float4 packDist_8;
  half4 tmpvar_9;
  tmpvar_9 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(_mtl_i.xlv_TEXCOORD3));
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
  normal_13 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_22 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_23;
  tmpvar_23 = dot (normal_22, lightDir_21);
  half4 tmpvar_24;
  tmpvar_24 = (c_15 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_23))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_23))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_24.w;
  color_2.xyz = (tmpvar_24.xyz * ((half)2.0 * tmpvar_24.w));
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
// Stats: 47 math, 6 textures
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
def c10, 2.00000000, 0, 0, 0
dcl_texcoord2 v1
dcl_texcoord3 v2
dcl_texcoord4 v3.xyz
mov_pp r1.xyz, c7
dp3_pp r0.y, c0, c0
rsq_pp r0.y, r0.y
dp3_pp r0.x, v3, v3
rcp r0.w, v2.w
mul_pp r1.xyz, c6, r1
mul_pp r2.xyz, r0.y, c0
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v3
dp3_pp r0.z, r0, r2
mul_pp r2.xyz, r0.z, r1
mad r0.xy, v2, r0.w, c5
mad r1.xy, v2, r0.w, c4
texld r0.x, r0, s2
texld r1.x, r1, s2
mov r1.w, r0.x
mad r0.xy, v2, r0.w, c3
texld r0.x, r0, s2
mov r1.z, r1.x
mad r1.xy, v2, r0.w, c2
texld r1.x, r1, s2
mov r1.y, r0.x
dp4 r0.x, c0, c0
mad r1, -v2.z, r0.w, r1
mov r0.y, c1.x
cmp r1, r1, c8.y, r0.y
dp4_pp r0.y, r1, c8.z
rsq r0.x, r0.x
mul r1.xyz, r0.x, c0
dp3_pp r1.z, v3, r1
rcp r0.x, v1.w
mad r1.xy, v1, r0.x, c8.x
texld r0.w, r1, s0
cmp r1.x, -v1.z, c8.w, c8.y
dp3 r0.x, v1, v1
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c10.x
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
// Stats: 47 math, 6 textures
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
def c10, 2.00000000, 0, 0, 0
dcl_texcoord2 v1
dcl_texcoord3 v2
dcl_texcoord4 v3.xyz
rcp r1.w, v2.w
mad r0.xyz, v2, r1.w, c5
mad r1.xyz, v2, r1.w, c3
texld r0.x, r0, s2
mov_pp r0.w, r0.x
mad r0.xyz, v2, r1.w, c4
texld r0.x, r0, s2
mov_pp r0.z, r0.x
texld r1.x, r1, s2
mov_pp r0.y, r1.x
mad r1.xyz, v2, r1.w, c2
mov r0.x, c1
add r1.w, c8.y, -r0.x
texld r0.x, r1, s2
mad r1, r0, r1.w, c1.x
dp4_pp r0.z, r1, c8.z
rcp r0.x, v1.w
mad r1.xy, v1, r0.x, c8.x
dp3 r0.x, v1, v1
texld r0.w, r1, s0
cmp r0.y, -v1.z, c8.w, c8
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s1
mul_pp r0.x, r0.y, r0
mul_pp r0.w, r0.x, r0.z
dp3_pp r0.y, c0, c0
rsq_pp r1.x, r0.y
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v3
mul_pp r1.xyz, r1.x, c0
dp3_pp r1.z, r0, r1
mul_pp r1.x, r0.w, r1.z
dp4 r1.w, c0, c0
rsq r0.x, r1.w
mul r0.xyz, r0.x, c0
mul_pp r1.w, r1.x, c9.x
dp3_pp r1.x, v3, r0
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c10.x
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 40 math, 2 textures
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
eefiecedbabicbgpkchefkmhaoemccblbkcifmopabaaaaaaoaahaaaaadaaaaaa
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
fdeieefchiagaaaaeaaaaaaajoabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpaoaaaaahocaabaaaaaaaaaaaagbjbaaa
aeaaaaaapgbpbaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaaehaaaaalbcaabaaaabaaaaaaegaabaaaabaaaaaa
aghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaaabaaaaaaaaaaaaaihcaabaaa
acaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaehaaaaalccaabaaa
abaaaaaaegaabaaaacaaaaaaaghabaaaacaaaaaaaagabaaaaaaaaaaackaabaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
aeaaaaaaehaaaaalicaabaaaabaaaaaajgafbaaaaaaaaaaaaghabaaaacaaaaaa
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
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaabdaaaaaa
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
agaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
agaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
// Stats: 38 math, 6 textures
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
  float4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
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
  P_5 = ((_mtl_i.xlv_TEXCOORD2.xy / _mtl_i.xlv_TEXCOORD2.w) + 0.5);
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_5));
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD2.xyz, _mtl_i.xlv_TEXCOORD2.xyz);
  half4 tmpvar_7;
  tmpvar_7 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_6)));
  half tmpvar_8;
  half4 shadows_9;
  float3 tmpvar_10;
  tmpvar_10 = (_mtl_i.xlv_TEXCOORD3.xyz / _mtl_i.xlv_TEXCOORD3.w);
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
  normal_22 = half3(_mtl_i.xlv_TEXCOORD4);
  half atten_23;
  atten_23 = half((((
    float((_mtl_i.xlv_TEXCOORD2.z > 0.0))
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
  normal_31 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_32;
  tmpvar_32 = dot (normal_31, lightDir_30);
  half4 tmpvar_33;
  tmpvar_33 = (c_24 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_32))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_32))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_33.w;
  color_2.xyz = (tmpvar_33.xyz * ((half)2.0 * tmpvar_33.w));
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
// Stats: 46 math, 5 textures
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
def c8, -1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
dcl_texcoord4 v3.xyz
add r0.xyz, v2, c5.xyyw
texld r0, r0, s0
dp4 r2.w, r0, c6
add r0.xyz, v2, c5.yxyw
texld r0, r0, s0
dp4 r2.z, r0, c6
add r1.xyz, v2, c5.yyxw
texld r1, r1, s0
dp4 r2.y, r1, c6
add r0.xyz, v2, c5.x
texld r0, r0, s0
dp3 r1.x, v2, v2
dp4 r2.x, r0, c6
rsq r1.x, r1.x
rcp r0.x, r1.x
mul r0.x, r0, c1.w
mad r0, -r0.x, c5.z, r2
mov r1.x, c2
cmp r1, r0, c5.w, r1.x
dp3 r0.x, v1, v1
dp4_pp r0.y, r1, c7.x
texld r0.x, r0.x, s1
mul r1.w, r0.x, r0.y
dp3_pp r0.y, c0, c0
rsq_pp r0.w, r0.y
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v3
dp3_pp r1.x, r0, r1
dp4 r0.w, c0, c0
rsq r0.x, r0.w
mul_pp r0.w, r1, r1.x
mul r0.xyz, r0.x, c0
dp3_pp r1.z, v3, r0
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c8.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 40 math, 5 textures
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
eefiecedlpokccdalhbliipdgabifjhippafobndabaaaaaaoaahaaaaadaaaaaa
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
fdeieefchiagaaaaeaaaaaaajoabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhafidibddaaaaaaakocaabaaaaaaaaaaaagbjbaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadmefaaaaajpcaabaaa
acaaaaaajgahbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabbaaaaak
ccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdh
afidibddaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaaabaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhafidibddaaaaaaakocaabaaa
aaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalmaaaaaalm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhafidibdddbaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaa
agaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaa
acaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaaj
ccaabaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaa
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
agaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
agaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
// Stats: 41 math, 5 textures, 4 branches
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_4)));
  float tmpvar_6;
  float4 shadowVals_7;
  float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float3 vec_9;
  vec_9 = (_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, 0.0078125, 0.0078125));
  float4 packDist_10;
  half4 tmpvar_11;
  tmpvar_11 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_9));
  packDist_10 = float4(tmpvar_11);
  shadowVals_7.x = dot (packDist_10, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_12;
  vec_12 = (_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, -0.0078125, 0.0078125));
  float4 packDist_13;
  half4 tmpvar_14;
  tmpvar_14 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_12));
  packDist_13 = float4(tmpvar_14);
  shadowVals_7.y = dot (packDist_13, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_15;
  vec_15 = (_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, 0.0078125, -0.0078125));
  float4 packDist_16;
  half4 tmpvar_17;
  tmpvar_17 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_15));
  packDist_16 = float4(tmpvar_17);
  shadowVals_7.z = dot (packDist_16, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_18;
  vec_18 = (_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, -0.0078125, -0.0078125));
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
  normal_30 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_39 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_40;
  tmpvar_40 = dot (normal_39, lightDir_38);
  half4 tmpvar_41;
  tmpvar_41 = (c_32 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_40))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_40))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_41.w;
  color_2.xyz = (tmpvar_41.xyz * ((half)2.0 * tmpvar_41.w));
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
// Stats: 47 math, 6 textures
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
def c8, -1.00000000, 2.00000000, 0, 0
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
dcl_texcoord4 v3.xyz
add r0.xyz, v2, c5.xyyw
texld r0, r0, s0
dp4 r2.w, r0, c6
add r0.xyz, v2, c5.yxyw
texld r0, r0, s0
dp4 r2.z, r0, c6
add r1.xyz, v2, c5.yyxw
texld r1, r1, s0
dp4 r2.y, r1, c6
add r0.xyz, v2, c5.x
texld r0, r0, s0
dp3 r1.x, v2, v2
dp4 r2.x, r0, c6
rsq r1.x, r1.x
rcp r0.x, r1.x
mul r0.x, r0, c1.w
mad r0, -r0.x, c5.z, r2
mov r1.x, c2
cmp r0, r0, c5.w, r1.x
dp4_pp r0.y, r0, c7.x
dp3 r0.x, v1, v1
texld r0.w, v1, s2
texld r0.x, r0.x, s1
mul r0.x, r0, r0.w
mul r1.w, r0.x, r0.y
dp3_pp r0.y, c0, c0
rsq_pp r0.w, r0.y
mul_pp r1.xyz, r0.w, c0
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v3
dp3_pp r1.x, r0, r1
dp4 r0.w, c0, c0
rsq r0.x, r0.w
mul_pp r0.w, r1, r1.x
mul r0.xyz, r0.x, c0
dp3_pp r1.z, v3, r0
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
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c8.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 41 math, 6 textures
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
eefiecedojhnomfcfbldbhpblodlpampopmbgdfkabaaaaaadmaiaaaaadaaaaaa
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
fdeieefcneagaaaaeaaaaaaalfabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhafidibddaaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadmefaaaaajpcaabaaaacaaaaaa
jgahbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaabbaaaaakccaabaaa
abaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhafidibdd
aaaaaaakocaabaaaaaaaaaaaagbjbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaalm
aaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaaabaaaaaaegaobaaaacaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhafidibddaaaaaaakocaabaaaaaaaaaaa
agbjbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalmaaaaaalmefaaaaaj
pcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
bbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadl
icabibdhafidibdddbaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaa
aaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaacaaaaaa
biaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiado
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeabaaaaaajccaabaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagijcaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaafaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaapaaaaaadiaaaaah
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
aaaaaaaaegaobaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 42 math, 6 textures, 4 branches
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
  tmpvar_4 = dot (_mtl_i.xlv_TEXCOORD2, _mtl_i.xlv_TEXCOORD2);
  half4 tmpvar_5;
  tmpvar_5 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_4)));
  half4 tmpvar_6;
  tmpvar_6 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(_mtl_i.xlv_TEXCOORD2));
  float tmpvar_7;
  float4 shadowVals_8;
  float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (_mtl_i.xlv_TEXCOORD3, _mtl_i.xlv_TEXCOORD3)
  ) * _mtl_u._LightPositionRange.w) * 0.97);
  float3 vec_10;
  vec_10 = (_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, 0.0078125, 0.0078125));
  float4 packDist_11;
  half4 tmpvar_12;
  tmpvar_12 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_10));
  packDist_11 = float4(tmpvar_12);
  shadowVals_8.x = dot (packDist_11, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_13;
  vec_13 = (_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, -0.0078125, 0.0078125));
  float4 packDist_14;
  half4 tmpvar_15;
  tmpvar_15 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_13));
  packDist_14 = float4(tmpvar_15);
  shadowVals_8.y = dot (packDist_14, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_16;
  vec_16 = (_mtl_i.xlv_TEXCOORD3 + float3(-0.0078125, 0.0078125, -0.0078125));
  float4 packDist_17;
  half4 tmpvar_18;
  tmpvar_18 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, (float3)(vec_16));
  packDist_17 = float4(tmpvar_18);
  shadowVals_8.z = dot (packDist_17, float4(1.0, 0.00392157, 1.53787e-05, 6.03086e-08));
  float3 vec_19;
  vec_19 = (_mtl_i.xlv_TEXCOORD3 + float3(0.0078125, -0.0078125, -0.0078125));
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
  normal_31 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_40 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_41;
  tmpvar_41 = dot (normal_40, lightDir_39);
  half4 tmpvar_42;
  tmpvar_42 = (c_33 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_41))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_41))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_42.w;
  color_2.xyz = (tmpvar_42.xyz * ((half)2.0 * tmpvar_42.w));
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
// Stats: 24 math, 1 textures
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
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
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
  tmpvar_5 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_6;
  tmpvar_6 = tmpvar_5;
  float tmpvar_7;
  tmpvar_7 = (_mtl_u._LightShadowData.x + ((float)tmpvar_6 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_4 = half(tmpvar_7);
  half3 lightDir_8;
  lightDir_8 = tmpvar_3;
  half3 normal_9;
  normal_9 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_18 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_19;
  tmpvar_19 = dot (normal_18, lightDir_17);
  half4 tmpvar_20;
  tmpvar_20 = (c_11 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_19))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_19))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_20.w;
  color_2.xyz = (tmpvar_20.xyz * ((half)2.0 * tmpvar_20.w));
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
// Stats: 25 math, 2 textures
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
  float2 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD4;
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
  tmpvar_4 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(_mtl_i.xlv_TEXCOORD2));
  half shadow_5;
  half tmpvar_6;
  tmpvar_6 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD3.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD3.xyz).z);
  half tmpvar_7;
  tmpvar_7 = tmpvar_6;
  float tmpvar_8;
  tmpvar_8 = (_mtl_u._LightShadowData.x + ((float)tmpvar_7 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_5 = half(tmpvar_8);
  half3 lightDir_9;
  lightDir_9 = tmpvar_3;
  half3 normal_10;
  normal_10 = half3(_mtl_i.xlv_TEXCOORD4);
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
  normal_19 = half3(_mtl_i.xlv_TEXCOORD4);
  half tmpvar_20;
  tmpvar_20 = dot (normal_19, lightDir_18);
  half4 tmpvar_21;
  tmpvar_21 = (c_12 * mix ((half)1.0, clamp (
    floor(((half)1.01 + tmpvar_20))
  , (half)0.0, (half)1.0), clamp (
    ((half)10.0 * -(tmpvar_20))
  , (half)0.0, (half)1.0)));
  color_2.w = tmpvar_21.w;
  color_2.xyz = (tmpvar_21.xyz * ((half)2.0 * tmpvar_21.w));
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