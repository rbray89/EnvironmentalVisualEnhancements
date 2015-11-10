// Compiled shader for all platforms, uncompressed size: 580.4KB

Shader "EVE/Atmosphere" {
Properties {
 _Color ("Color Tint", Color) = (1,1,1,1)
 _OceanRadius ("Ocean Radius", Float) = 63000
 _SphereRadius ("Sphere Radius", Float) = 67000
 _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
 _SunsetColor ("Color Sunset", Color) = (1,0,0,0.45)
 _DensityFactorA ("Density RatioA", Float) = 0.22
 _DensityFactorB ("Density RatioB", Float) = 800
 _DensityFactorC ("Density RatioC", Float) = 1
 _DensityFactorD ("Density RatioD", Float) = 1
 _DensityFactorE ("Density RatioE", Float) = 1
 _Scale ("Scale", Float) = 1
 _Visibility ("Visibility", Float) = 0.0001
 _DensityVisibilityBase ("_DensityVisibilityBase", Float) = 1
 _DensityVisibilityPow ("_DensityVisibilityPow", Float) = 1
 _DensityVisibilityOffset ("_DensityVisibilityOffset", Float) = 1
 _DensityCutoffBase ("_DensityCutoffBase", Float) = 1
 _DensityCutoffPow ("_DensityCutoffPow", Float) = 1
 _DensityCutoffOffset ("_DensityCutoffyOffset", Float) = 1
 _DensityCutoffScale ("_DensityCutoffScale", Float) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent-3" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 18 avg math (18..19)
 //        d3d9 : 21 avg math (19..24)
 //       gles3 : 164 avg math (162..166), 1 avg texture (1..2)
 //       metal : 10 avg math (9..11)
 //      opengl : 162 avg math (162..163), 1 avg texture (1..2)
 // Stats for Fragment shader:
 //       d3d11 : 137 avg math (136..138), 1 avg texture (1..2)
 //        d3d9 : 168 math, 1 avg texture (1..2)
 //       metal : 164 avg math (162..166), 1 avg texture (1..2)
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent-3" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Lighting On
  ZTest False
  ZWrite Off
  Cull Front
  Fog { Mode Off }
  Blend OneMinusDstAlpha One
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 21 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 228
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 224 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 21 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 228
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 224 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 21 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 228
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 224 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 21 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 228
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 224 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_7.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_7);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 484
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 480 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_7.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_7);
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_7.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_7);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 484
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 480 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_7.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_7);
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_7.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_7);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 484
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 480 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_7.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_7);
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_7.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_7);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 484
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Float 480 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._Object2World * float4(0.0, 0.0, 0.0, 1.0)).xyz;
  float4 o_4;
  float4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  float2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _mtl_u._ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_7;
  cse_7 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_7.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_7);
  _mtl_o.xlv_TEXCOORD4 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD5 = ((tmpvar_3 - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 244
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 224 [_PlanetOrigin] 3
Float 240 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 244
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 224 [_PlanetOrigin] 3
Float 240 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 244
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 224 [_PlanetOrigin] 3
Float 240 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((_LightColor0.w * 
    (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0))
  ) * 2.0));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 18 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
}
SubProgram "gles3 " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, ((_LightColor0.w * 
    (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0))
  ) * 2.0));
  highp float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_38);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, 0.0, 1.0)
  ), clamp (tmpvar_37, 0.0, 1.0), NdotL_2));
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_40;
  tmpvar_40 = (1.0 - tmpvar_39);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 244
Matrix 32 [glstate_matrix_mvp]
Matrix 96 [glstate_matrix_modelview0]
Matrix 160 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 224 [_PlanetOrigin] 3
Float 240 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD1 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 163 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec3 _PlanetOrigin;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ZBufferParams;
uniform vec4 _WorldSpaceLightPos0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform float _OceanRadius;
uniform float _SphereRadius;
uniform float _DensityFactorA;
uniform float _DensityFactorB;
uniform float _DensityFactorC;
uniform float _DensityFactorD;
uniform float _DensityFactorE;
uniform float _Scale;
uniform float _Visibility;
uniform float _DensityVisibilityBase;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityOffset;
uniform float _DensityCutoffBase;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/((
    (_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x)
   + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  float cse_6;
  cse_6 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_5 = sqrt((cse_6 - (tmpvar_4 * tmpvar_4)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_5, 2.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((cse_6 - tmpvar_7));
  float tmpvar_9;
  tmpvar_9 = (_Scale * _OceanRadius);
  float tmpvar_10;
  tmpvar_10 = min (mix (tmpvar_2, (tmpvar_4 - 
    sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_7))
  ), (
    float((tmpvar_9 >= tmpvar_5))
   * 
    float((tmpvar_4 >= 0.0))
  )), tmpvar_2);
  float tmpvar_11;
  tmpvar_11 = sqrt(cse_6);
  vec3 tmpvar_12;
  tmpvar_12 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  vec3 x_13;
  x_13 = ((_WorldSpaceCameraPos + (tmpvar_10 * tmpvar_3)) - tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = float((tmpvar_4 >= 0.0));
  float tmpvar_15;
  tmpvar_15 = mix ((tmpvar_10 + tmpvar_8), max (0.0, (tmpvar_10 - tmpvar_4)), tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_14 * tmpvar_4);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_10)), tmpvar_14);
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * 
    (tmpvar_15 * tmpvar_15)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_19;
  tmpvar_19 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_20;
  tmpvar_20 = sqrt(((_DensityFactorC * 
    (tmpvar_16 * tmpvar_16)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float tmpvar_21;
  tmpvar_21 = sqrt(((_DensityFactorC * 
    (tmpvar_17 * tmpvar_17)
  ) + (_DensityFactorB * 
    (tmpvar_5 * tmpvar_5)
  )));
  float cse_22;
  cse_22 = (-2.0 * _DensityFactorA);
  vec4 tmpvar_23;
  tmpvar_23 = normalize(_WorldSpaceLightPos0);
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_3, tmpvar_23.xyz);
  float tmpvar_25;
  tmpvar_25 = dot (normalize(-(xlv_TEXCOORD5)), tmpvar_23.xyz);
  float tmpvar_26;
  tmpvar_26 = max (0.0, ((
    (_LightColor0.w * (clamp (tmpvar_25, 0.0, 1.0) + clamp (tmpvar_24, 0.0, 1.0)))
   * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x));
  color_1.w = (_Color.w * clamp ((
    ((((
      ((cse_22 * _DensityFactorD) * (tmpvar_18 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_19 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)) + (((
      ((cse_22 * _DensityFactorD) * (tmpvar_20 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_20 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC) - ((
      ((cse_22 * _DensityFactorD) * (tmpvar_21 + _DensityFactorD))
     * 
      pow (2.71828, (-((tmpvar_21 + _DensityFactorE)) / _DensityFactorD))
    ) / _DensityFactorC)))
   + 
    (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, 
      (-(_DensityCutoffPow) * (tmpvar_11 + _DensityCutoffOffset))
    )), 0.0, 1.0) * ((_Visibility * tmpvar_10) * pow (_DensityVisibilityBase, (
      -(_DensityVisibilityPow)
     * 
      ((0.5 * (tmpvar_11 + sqrt(
        dot (x_13, x_13)
      ))) + _DensityVisibilityOffset)
    ))))
  ), 0.0, 1.0));
  color_1.w = (color_1.w * mix ((
    (1.0 - (float((
      (_Scale * _SphereRadius)
     >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))
   * 
    clamp (tmpvar_26, 0.0, 1.0)
  ), clamp (tmpvar_26, 0.0, 1.0), tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = ((1.0 - clamp (
    dot (normalize(((_WorldSpaceCameraPos + 
      ((sign(tmpvar_4) * tmpvar_8) * tmpvar_3)
    ) - tmpvar_12)), tmpvar_23.xyz)
  , 0.0, 1.0)) * clamp (pow (tmpvar_24, 5.0), 0.0, 1.0));
  color_1.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_27)).xyz;
  color_1.w = mix (color_1.w, (color_1.w * _SunsetColor.w), tmpvar_27);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_PlanetOrigin]
Float 16 [_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_6.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 500
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 480 [_PlanetOrigin] 3
Float 496 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_6;
  cse_6 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_6.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_6);
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_6.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 500
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 480 [_PlanetOrigin] 3
Float 496 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_6;
  cse_6 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_6.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_6);
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_6.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 500
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 480 [_PlanetOrigin] 3
Float 496 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_6;
  cse_6 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_6.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_6);
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Scale;
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = cse_6.xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump float bodyCheck_4;
  mediump float sphereCheck_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = textureProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_ZBufferParams.z * depth_7)
   + _ZBufferParams.w))) * _Scale);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  highp float cse_14;
  cse_14 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  highp float tmpvar_17;
  tmpvar_17 = (_Scale * _OceanRadius);
  highp float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (float((
    (_Scale * _SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), sphereCheck_5), tmpvar_10);
  highp float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos);
  highp vec3 x_23;
  x_23 = ((_WorldSpaceCameraPos + (tmpvar_20 * worldDir_6)) - tmpvar_22);
  highp float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), sphereCheck_5);
  highp float tmpvar_26;
  tmpvar_26 = (sphereCheck_5 * tmpvar_12);
  highp float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), sphereCheck_5);
  highp float tmpvar_28;
  tmpvar_28 = sqrt(((_DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_29;
  tmpvar_29 = sqrt((_DensityFactorB * (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_30;
  tmpvar_30 = sqrt(((_DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((_DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  highp float tmpvar_32;
  highp float cse_33;
  cse_33 = (-2.0 * _DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _DensityFactorD) * (tmpvar_28 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_29 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  ) + (
    ((((cse_33 * _DensityFactorD) * (tmpvar_30 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
   - 
    ((((cse_33 * _DensityFactorD) * (tmpvar_31 + _DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _DensityFactorE))
     / _DensityFactorD))) / _DensityFactorC)
  )) + (clamp (
    (_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_21 + _DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_Visibility * tmpvar_20)
   * 
    pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  highp float tmpvar_36;
  tmpvar_36 = dot (normalize(-(xlv_TEXCOORD5)), lightDirection_3);
  NdotL_2 = tmpvar_36;
  lowp float shadow_37;
  mediump float tmpvar_38;
  tmpvar_38 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_39;
  tmpvar_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (_LightShadowData.x + (tmpvar_39 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, ((
    (_LightColor0.w * (clamp (NdotL_2, 0.0, 1.0) + clamp (tmpvar_35, 0.0, 1.0)))
   * 2.0) * shadow_37));
  highp float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_42);
  color_8.w = (color_8.w * mix ((
    (1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, 0.0, 1.0)
  ), clamp (tmpvar_41, 0.0, 1.0), NdotL_2));
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * worldDir_6)) - tmpvar_22)
  ), lightDirection_3), 0.0, 1.0);
  mediump float tmpvar_44;
  tmpvar_44 = (1.0 - tmpvar_43);
  mediump float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, 5.0), 0.0, 1.0));
  color_8.xyz = mix (_Color, _SunsetColor, vec4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 500
Matrix 32 [unity_World2Shadow0]
Matrix 96 [unity_World2Shadow1]
Matrix 160 [unity_World2Shadow2]
Matrix 224 [unity_World2Shadow3]
Matrix 288 [glstate_matrix_mvp]
Matrix 352 [glstate_matrix_modelview0]
Matrix 416 [_Object2World]
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ProjectionParams]
Vector 480 [_PlanetOrigin] 3
Float 496 [_Scale]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ProjectionParams;
  float4x4 unity_World2Shadow[4];
  float4x4 glstate_matrix_mvp;
  float4x4 glstate_matrix_modelview0;
  float4x4 _Object2World;
  float3 _PlanetOrigin;
  float _Scale;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  float4 o_3;
  float4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  float2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _mtl_u._ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((_mtl_u.glstate_matrix_modelview0 * _mtl_i._glesVertex).z);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_1;
  float4 cse_6;
  cse_6 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = cse_6.xyz;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u.unity_World2Shadow[0] * cse_6);
  _mtl_o.xlv_TEXCOORD4 = _mtl_u._PlanetOrigin;
  _mtl_o.xlv_TEXCOORD5 = ((_mtl_u._PlanetOrigin - _mtl_u._WorldSpaceCameraPos) * _mtl_u._Scale);
  return _mtl_o;
}

"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v3, r1
dp3 r3.w, v3, v3
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.y, r1.w, c22, c22.x
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.y
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.x, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.x, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4.y, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.x, r0
mad r0.y, r4, r0.z, r4.x
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v2, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mov r0.x, r3
mul r4.z, r4, c14.x
mul r0.z, r4, r0.y
mul_sat r0.y, r0.x, c21.x
mul r0.y, r0, r0.z
dp4_pp r0.x, c2, c2
mad_sat r3.w, r5.x, c23.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c2
mul r3.xyz, r4.w, -v3
dp3 r3.y, r0, r3
dp3_pp r0.w, r1, r0
mov_pp_sat r3.x, r3.y
mov_pp_sat r3.z, r0.w
add_pp r3.z, r3.x, r3
mul_pp r3.x, r3.w, c4.w
mul_pp r3.w, r3.z, c3
mov r3.z, c13.x
mad r3.z, c7.x, r3, -r2.w
mul_pp r3.w, r3, c23.z
max_pp_sat r2.w, r3, c22.x
cmp r3.w, r3.z, c22.y, c22.x
cmp r3.z, r1.w, c22.x, c22.y
cmp r1.w, -r1, c22.x, c22.y
add r1.w, r1, -r3.z
mul r3.z, r4.y, r3.w
mul r1.w, r1, r4.x
add_pp r3.z, -r3, c22.y
mad r1.xyz, r1.w, r1, c0
add r1.xyz, r1, -r2
mul_pp r1.w, r3.z, r2
mad_pp r3.w, -r3.z, r2, r2
mad_pp r2.x, r3.y, r3.w, r1.w
mul_pp r2.w, r3.x, r2.x
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r1
pow_pp_sat r1, r0.w, c22.z
dp3_sat r0.x, r2, r0
mov_pp r0.y, r1.x
add r0.x, -r0, c22.y
mov_pp r1.xyz, c5
mul_pp r0.x, r0, r0.y
mad_pp r3.x, r2.w, c5.w, -r2.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r3.x, r2
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 136 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_SunsetColor]
Float 80 [_OceanRadius]
Float 84 [_SphereRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmonkoonmmkfdmmjcfhpbjeffpdhgiheeabaaaaaadmbcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdebbaaaaeaaaaaaaenaeaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaagaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaahaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaahaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
adaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaaegbcbaiaebaaaaaa
aeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaapcaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaa
agijcaaaabaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaa
aeaaaaaafgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaa
adaaaaaaegiicaaaaaaaaaaaaeaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 128
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
VectorHalf 56 [_SunsetColor] 4
Float 64 [_OceanRadius]
Float 68 [_SphereRadius]
Float 72 [_DensityFactorA]
Float 76 [_DensityFactorB]
Float 80 [_DensityFactorC]
Float 84 [_DensityFactorD]
Float 88 [_DensityFactorE]
Float 92 [_Scale]
Float 96 [_Visibility]
Float 100 [_DensityVisibilityBase]
Float 104 [_DensityVisibilityPow]
Float 108 [_DensityVisibilityOffset]
Float 112 [_DensityCutoffBase]
Float 116 [_DensityCutoffPow]
Float 120 [_DensityCutoffOffset]
Float 124 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(0)]], sampler _mtlsmp__CameraDepthTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half tmpvar_37;
  tmpvar_37 = max ((half)0.0, ((_mtl_u._LightColor0.w * 
    (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0))
  ) * (half)2.0));
  float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_38));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, (half)0.0, (half)1.0)
  ), clamp (tmpvar_37, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_40;
  tmpvar_40 = half((1.0 - tmpvar_39));
  half tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v3, r1
dp3 r3.w, v3, v3
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.y, r1.w, c22, c22.x
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.y
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.x, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.x, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4.y, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.x, r0
mad r0.y, r4, r0.z, r4.x
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v2, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mov r0.x, r3
mul r4.z, r4, c14.x
mul r0.z, r4, r0.y
mul_sat r0.y, r0.x, c21.x
mul r0.y, r0, r0.z
dp4_pp r0.x, c2, c2
mad_sat r3.w, r5.x, c23.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c2
mul r3.xyz, r4.w, -v3
dp3 r3.y, r0, r3
dp3_pp r0.w, r1, r0
mov_pp_sat r3.x, r3.y
mov_pp_sat r3.z, r0.w
add_pp r3.z, r3.x, r3
mul_pp r3.x, r3.w, c4.w
mul_pp r3.w, r3.z, c3
mov r3.z, c13.x
mad r3.z, c7.x, r3, -r2.w
mul_pp r3.w, r3, c23.z
max_pp_sat r2.w, r3, c22.x
cmp r3.w, r3.z, c22.y, c22.x
cmp r3.z, r1.w, c22.x, c22.y
cmp r1.w, -r1, c22.x, c22.y
add r1.w, r1, -r3.z
mul r3.z, r4.y, r3.w
mul r1.w, r1, r4.x
add_pp r3.z, -r3, c22.y
mad r1.xyz, r1.w, r1, c0
add r1.xyz, r1, -r2
mul_pp r1.w, r3.z, r2
mad_pp r3.w, -r3.z, r2, r2
mad_pp r2.x, r3.y, r3.w, r1.w
mul_pp r2.w, r3.x, r2.x
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r1
pow_pp_sat r1, r0.w, c22.z
dp3_sat r0.x, r2, r0
mov_pp r0.y, r1.x
add r0.x, -r0, c22.y
mov_pp r1.xyz, c5
mul_pp r0.x, r0, r0.y
mad_pp r3.x, r2.w, c5.w, -r2.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r3.x, r2
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 136 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_SunsetColor]
Float 80 [_OceanRadius]
Float 84 [_SphereRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmonkoonmmkfdmmjcfhpbjeffpdhgiheeabaaaaaadmbcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdebbaaaaeaaaaaaaenaeaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaagaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaahaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaahaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
adaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaaegbcbaiaebaaaaaa
aeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaapcaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaa
agijcaaaabaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaa
aeaaaaaafgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaa
adaaaaaaegiicaaaaaaaaaaaaeaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 128
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
VectorHalf 56 [_SunsetColor] 4
Float 64 [_OceanRadius]
Float 68 [_SphereRadius]
Float 72 [_DensityFactorA]
Float 76 [_DensityFactorB]
Float 80 [_DensityFactorC]
Float 84 [_DensityFactorD]
Float 88 [_DensityFactorE]
Float 92 [_Scale]
Float 96 [_Visibility]
Float 100 [_DensityVisibilityBase]
Float 104 [_DensityVisibilityPow]
Float 108 [_DensityVisibilityOffset]
Float 112 [_DensityCutoffBase]
Float 116 [_DensityCutoffPow]
Float 120 [_DensityCutoffOffset]
Float 124 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(0)]], sampler _mtlsmp__CameraDepthTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half tmpvar_37;
  tmpvar_37 = max ((half)0.0, ((_mtl_u._LightColor0.w * 
    (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0))
  ) * (half)2.0));
  float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_38));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, (half)0.0, (half)1.0)
  ), clamp (tmpvar_37, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_40;
  tmpvar_40 = half((1.0 - tmpvar_39));
  half tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v3, r1
dp3 r3.w, v3, v3
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.y, r1.w, c22, c22.x
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.y
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.x, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.x, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4.y, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.x, r0
mad r0.y, r4, r0.z, r4.x
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v2, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mov r0.x, r3
mul r4.z, r4, c14.x
mul r0.z, r4, r0.y
mul_sat r0.y, r0.x, c21.x
mul r0.y, r0, r0.z
dp4_pp r0.x, c2, c2
mad_sat r3.w, r5.x, c23.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c2
mul r3.xyz, r4.w, -v3
dp3 r3.y, r0, r3
dp3_pp r0.w, r1, r0
mov_pp_sat r3.x, r3.y
mov_pp_sat r3.z, r0.w
add_pp r3.z, r3.x, r3
mul_pp r3.x, r3.w, c4.w
mul_pp r3.w, r3.z, c3
mov r3.z, c13.x
mad r3.z, c7.x, r3, -r2.w
mul_pp r3.w, r3, c23.z
max_pp_sat r2.w, r3, c22.x
cmp r3.w, r3.z, c22.y, c22.x
cmp r3.z, r1.w, c22.x, c22.y
cmp r1.w, -r1, c22.x, c22.y
add r1.w, r1, -r3.z
mul r3.z, r4.y, r3.w
mul r1.w, r1, r4.x
add_pp r3.z, -r3, c22.y
mad r1.xyz, r1.w, r1, c0
add r1.xyz, r1, -r2
mul_pp r1.w, r3.z, r2
mad_pp r3.w, -r3.z, r2, r2
mad_pp r2.x, r3.y, r3.w, r1.w
mul_pp r2.w, r3.x, r2.x
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r1
pow_pp_sat r1, r0.w, c22.z
dp3_sat r0.x, r2, r0
mov_pp r0.y, r1.x
add r0.x, -r0, c22.y
mov_pp r1.xyz, c5
mul_pp r0.x, r0, r0.y
mad_pp r3.x, r2.w, c5.w, -r2.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r3.x, r2
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 136 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_SunsetColor]
Float 80 [_OceanRadius]
Float 84 [_SphereRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmonkoonmmkfdmmjcfhpbjeffpdhgiheeabaaaaaadmbcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdebbaaaaeaaaaaaaenaeaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaagaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaahaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaahaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
adaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaaegbcbaiaebaaaaaa
aeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaapcaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaa
agijcaaaabaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaa
aeaaaaaafgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaa
adaaaaaaegiicaaaaaaaaaaaaeaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 128
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
VectorHalf 56 [_SunsetColor] 4
Float 64 [_OceanRadius]
Float 68 [_SphereRadius]
Float 72 [_DensityFactorA]
Float 76 [_DensityFactorB]
Float 80 [_DensityFactorC]
Float 84 [_DensityFactorD]
Float 88 [_DensityFactorE]
Float 92 [_Scale]
Float 96 [_Visibility]
Float 100 [_DensityVisibilityBase]
Float 104 [_DensityVisibilityPow]
Float 108 [_DensityVisibilityOffset]
Float 112 [_DensityCutoffBase]
Float 116 [_DensityCutoffPow]
Float 120 [_DensityCutoffOffset]
Float 124 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(0)]], sampler _mtlsmp__CameraDepthTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half tmpvar_37;
  tmpvar_37 = max ((half)0.0, ((_mtl_u._LightColor0.w * 
    (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0))
  ) * (half)2.0));
  float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_38));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, (half)0.0, (half)1.0)
  ), clamp (tmpvar_37, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_40;
  tmpvar_40 = half((1.0 - tmpvar_39));
  half tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v4, r1
dp3 r3.w, v4, v4
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.x, r1.w, c22.y, c22
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.x
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.y, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.y, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.y, r0
mad r0.y, r4.x, r0.z, r4
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4.x
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v3, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mul r4.z, r4, c14.x
mov r0.x, r3
mul r0.y, r4.z, r0
mul_sat r0.x, r0, c21
mul r0.y, r0.x, r0
mad_sat r0.y, r5.x, c23.x, r0
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, c2
mul_pp r0.w, r0.y, c4
mul r0.xyz, r4.w, -v4
dp3 r4.z, r3, r0
dp3_pp r3.w, r1, r3
mov_pp_sat r0.x, r4.z
mov_pp_sat r0.y, r3.w
add_pp r0.y, r0.x, r0
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
mov r0.x, c13
mad r0.x, c7, r0, -r2.w
cmp r0.z, r0.x, c22.y, c22.x
mul_pp r0.y, r0, c23.z
max_pp_sat r2.w, r0.y, c22.x
cmp r0.y, r1.w, c22.x, c22
cmp r0.x, -r1.w, c22, c22.y
add r0.x, r0, -r0.y
mul r0.y, r4.x, r0.z
add_pp r1.w, -r0.y, c22.y
mul r0.x, r0, r4.y
mad r0.xyz, r0.x, r1, c0
add r0.xyz, r0, -r2
mul_pp r1.x, r1.w, r2.w
mad_pp r4.x, -r1.w, r2.w, r2.w
mad_pp r1.y, r4.z, r4.x, r1.x
mul_pp r1.w, r0, r1.y
dp3 r1.x, r0, r0
rsq r0.w, r1.x
mul r1.xyz, r0.w, r0
pow_pp_sat r0, r3.w, c22.z
dp3_sat r0.y, r1, r3
add r0.y, -r0, c22
mov_pp r1.xyz, c5
mul_pp r0.x, r0.y, r0
mad_pp r2.x, r1.w, c5.w, -r1.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r2.x, r1
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 138 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 240
Vector 80 [_LightColor0]
Vector 112 [_Color]
Vector 128 [_SunsetColor]
Float 144 [_OceanRadius]
Float 148 [_SphereRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedoholjjpmoeolgnjgdbmiadfbpihemednabaaaaaanibcaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclibbaaaa
eaaaaaaagoaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaa
ckiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaalaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaaoaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaamaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaanaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegbcbaiaebaaaaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaacaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapcaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaaagijcaaa
abaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaaeaaaaaa
fgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaaahaaaaaa
egiicaaaaaaaaaaaaiaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v4, r1
dp3 r3.w, v4, v4
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.x, r1.w, c22.y, c22
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.x
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.y, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.y, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.y, r0
mad r0.y, r4.x, r0.z, r4
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4.x
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v3, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mul r4.z, r4, c14.x
mov r0.x, r3
mul r0.y, r4.z, r0
mul_sat r0.x, r0, c21
mul r0.y, r0.x, r0
mad_sat r0.y, r5.x, c23.x, r0
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, c2
mul_pp r0.w, r0.y, c4
mul r0.xyz, r4.w, -v4
dp3 r4.z, r3, r0
dp3_pp r3.w, r1, r3
mov_pp_sat r0.x, r4.z
mov_pp_sat r0.y, r3.w
add_pp r0.y, r0.x, r0
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
mov r0.x, c13
mad r0.x, c7, r0, -r2.w
cmp r0.z, r0.x, c22.y, c22.x
mul_pp r0.y, r0, c23.z
max_pp_sat r2.w, r0.y, c22.x
cmp r0.y, r1.w, c22.x, c22
cmp r0.x, -r1.w, c22, c22.y
add r0.x, r0, -r0.y
mul r0.y, r4.x, r0.z
add_pp r1.w, -r0.y, c22.y
mul r0.x, r0, r4.y
mad r0.xyz, r0.x, r1, c0
add r0.xyz, r0, -r2
mul_pp r1.x, r1.w, r2.w
mad_pp r4.x, -r1.w, r2.w, r2.w
mad_pp r1.y, r4.z, r4.x, r1.x
mul_pp r1.w, r0, r1.y
dp3 r1.x, r0, r0
rsq r0.w, r1.x
mul r1.xyz, r0.w, r0
pow_pp_sat r0, r3.w, c22.z
dp3_sat r0.y, r1, r3
add r0.y, -r0, c22
mov_pp r1.xyz, c5
mul_pp r0.x, r0.y, r0
mad_pp r2.x, r1.w, c5.w, -r1.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r2.x, r1
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 138 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 240
Vector 80 [_LightColor0]
Vector 112 [_Color]
Vector 128 [_SunsetColor]
Float 144 [_OceanRadius]
Float 148 [_SphereRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedoholjjpmoeolgnjgdbmiadfbpihemednabaaaaaanibcaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclibbaaaa
eaaaaaaagoaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaa
ckiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaalaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaaoaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaamaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaanaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegbcbaiaebaaaaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaacaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapcaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaaagijcaaa
abaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaaeaaaaaa
fgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaaahaaaaaa
egiicaaaaaaaaaaaaiaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v4, r1
dp3 r3.w, v4, v4
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.x, r1.w, c22.y, c22
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.x
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.y, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.y, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.y, r0
mad r0.y, r4.x, r0.z, r4
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4.x
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v3, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mul r4.z, r4, c14.x
mov r0.x, r3
mul r0.y, r4.z, r0
mul_sat r0.x, r0, c21
mul r0.y, r0.x, r0
mad_sat r0.y, r5.x, c23.x, r0
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, c2
mul_pp r0.w, r0.y, c4
mul r0.xyz, r4.w, -v4
dp3 r4.z, r3, r0
dp3_pp r3.w, r1, r3
mov_pp_sat r0.x, r4.z
mov_pp_sat r0.y, r3.w
add_pp r0.y, r0.x, r0
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
mov r0.x, c13
mad r0.x, c7, r0, -r2.w
cmp r0.z, r0.x, c22.y, c22.x
mul_pp r0.y, r0, c23.z
max_pp_sat r2.w, r0.y, c22.x
cmp r0.y, r1.w, c22.x, c22
cmp r0.x, -r1.w, c22, c22.y
add r0.x, r0, -r0.y
mul r0.y, r4.x, r0.z
add_pp r1.w, -r0.y, c22.y
mul r0.x, r0, r4.y
mad r0.xyz, r0.x, r1, c0
add r0.xyz, r0, -r2
mul_pp r1.x, r1.w, r2.w
mad_pp r4.x, -r1.w, r2.w, r2.w
mad_pp r1.y, r4.z, r4.x, r1.x
mul_pp r1.w, r0, r1.y
dp3 r1.x, r0, r0
rsq r0.w, r1.x
mul r1.xyz, r0.w, r0
pow_pp_sat r0, r3.w, c22.z
dp3_sat r0.y, r1, r3
add r0.y, -r0, c22
mov_pp r1.xyz, c5
mul_pp r0.x, r0.y, r0
mad_pp r2.x, r1.w, c5.w, -r1.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r2.x, r1
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 138 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 240
Vector 80 [_LightColor0]
Vector 112 [_Color]
Vector 128 [_SunsetColor]
Float 144 [_OceanRadius]
Float 148 [_SphereRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedoholjjpmoeolgnjgdbmiadfbpihemednabaaaaaanibcaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclibbaaaa
eaaaaaaagoaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaa
ckiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaalaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaaoaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaamaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaanaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegbcbaiaebaaaaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaacaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapcaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaaagijcaaa
abaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaaeaaaaaa
fgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaaahaaaaaa
egiicaaaaaaaaaaaaiaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 152
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
Vector 48 [_LightShadowData]
VectorHalf 64 [_LightColor0] 4
VectorHalf 72 [_Color] 4
VectorHalf 80 [_SunsetColor] 4
Float 88 [_OceanRadius]
Float 92 [_SphereRadius]
Float 96 [_DensityFactorA]
Float 100 [_DensityFactorB]
Float 104 [_DensityFactorC]
Float 108 [_DensityFactorD]
Float 112 [_DensityFactorE]
Float 116 [_Scale]
Float 120 [_Visibility]
Float 124 [_DensityVisibilityBase]
Float 128 [_DensityVisibilityPow]
Float 132 [_DensityVisibilityOffset]
Float 136 [_DensityCutoffBase]
Float 140 [_DensityCutoffPow]
Float 144 [_DensityCutoffOffset]
Float 148 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(1)]], sampler _mtlsmp__CameraDepthTexture [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half shadow_37;
  half tmpvar_38;
  tmpvar_38 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_39;
  tmpvar_39 = tmpvar_38;
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._LightShadowData.x + ((float)tmpvar_39 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_37 = half(tmpvar_40);
  half tmpvar_41;
  tmpvar_41 = max ((half)0.0, ((
    (_mtl_u._LightColor0.w * (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0)))
   * (half)2.0) * shadow_37));
  float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_42));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, (half)0.0, (half)1.0)
  ), clamp (tmpvar_41, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_44;
  tmpvar_44 = half((1.0 - tmpvar_43));
  half tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_OFF" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 152
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
Vector 48 [_LightShadowData]
VectorHalf 64 [_LightColor0] 4
VectorHalf 72 [_Color] 4
VectorHalf 80 [_SunsetColor] 4
Float 88 [_OceanRadius]
Float 92 [_SphereRadius]
Float 96 [_DensityFactorA]
Float 100 [_DensityFactorB]
Float 104 [_DensityFactorC]
Float 108 [_DensityFactorD]
Float 112 [_DensityFactorE]
Float 116 [_Scale]
Float 120 [_Visibility]
Float 124 [_DensityVisibilityBase]
Float 128 [_DensityVisibilityPow]
Float 132 [_DensityVisibilityOffset]
Float 136 [_DensityCutoffBase]
Float 140 [_DensityCutoffPow]
Float 144 [_DensityCutoffOffset]
Float 148 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(1)]], sampler _mtlsmp__CameraDepthTexture [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half shadow_37;
  half tmpvar_38;
  tmpvar_38 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_39;
  tmpvar_39 = tmpvar_38;
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._LightShadowData.x + ((float)tmpvar_39 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_37 = half(tmpvar_40);
  half tmpvar_41;
  tmpvar_41 = max ((half)0.0, ((
    (_mtl_u._LightColor0.w * (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0)))
   * (half)2.0) * shadow_37));
  float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_42));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, (half)0.0, (half)1.0)
  ), clamp (tmpvar_41, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_44;
  tmpvar_44 = half((1.0 - tmpvar_43));
  half tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_OFF" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 152
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
Vector 48 [_LightShadowData]
VectorHalf 64 [_LightColor0] 4
VectorHalf 72 [_Color] 4
VectorHalf 80 [_SunsetColor] 4
Float 88 [_OceanRadius]
Float 92 [_SphereRadius]
Float 96 [_DensityFactorA]
Float 100 [_DensityFactorB]
Float 104 [_DensityFactorC]
Float 108 [_DensityFactorD]
Float 112 [_DensityFactorE]
Float 116 [_Scale]
Float 120 [_Visibility]
Float 124 [_DensityVisibilityBase]
Float 128 [_DensityVisibilityPow]
Float 132 [_DensityVisibilityOffset]
Float 136 [_DensityCutoffBase]
Float 140 [_DensityCutoffPow]
Float 144 [_DensityCutoffOffset]
Float 148 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(1)]], sampler _mtlsmp__CameraDepthTexture [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half shadow_37;
  half tmpvar_38;
  tmpvar_38 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_39;
  tmpvar_39 = tmpvar_38;
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._LightShadowData.x + ((float)tmpvar_39 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_37 = half(tmpvar_40);
  half tmpvar_41;
  tmpvar_41 = max ((half)0.0, ((
    (_mtl_u._LightColor0.w * (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0)))
   * (half)2.0) * shadow_37));
  float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_42));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, (half)0.0, (half)1.0)
  ), clamp (tmpvar_41, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_44;
  tmpvar_44 = half((1.0 - tmpvar_43));
  half tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v3, r1
dp3 r3.w, v3, v3
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.y, r1.w, c22, c22.x
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.y
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.x, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.x, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4.y, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.x, r0
mad r0.y, r4, r0.z, r4.x
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v2, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mov r0.x, r3
mul r4.z, r4, c14.x
mul r0.z, r4, r0.y
mul_sat r0.y, r0.x, c21.x
mul r0.y, r0, r0.z
dp4_pp r0.x, c2, c2
mad_sat r3.w, r5.x, c23.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c2
mul r3.xyz, r4.w, -v3
dp3 r3.y, r0, r3
dp3_pp r0.w, r1, r0
mov_pp_sat r3.x, r3.y
mov_pp_sat r3.z, r0.w
add_pp r3.z, r3.x, r3
mul_pp r3.x, r3.w, c4.w
mul_pp r3.w, r3.z, c3
mov r3.z, c13.x
mad r3.z, c7.x, r3, -r2.w
mul_pp r3.w, r3, c23.z
max_pp_sat r2.w, r3, c22.x
cmp r3.w, r3.z, c22.y, c22.x
cmp r3.z, r1.w, c22.x, c22.y
cmp r1.w, -r1, c22.x, c22.y
add r1.w, r1, -r3.z
mul r3.z, r4.y, r3.w
mul r1.w, r1, r4.x
add_pp r3.z, -r3, c22.y
mad r1.xyz, r1.w, r1, c0
add r1.xyz, r1, -r2
mul_pp r1.w, r3.z, r2
mad_pp r3.w, -r3.z, r2, r2
mad_pp r2.x, r3.y, r3.w, r1.w
mul_pp r2.w, r3.x, r2.x
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r1
pow_pp_sat r1, r0.w, c22.z
dp3_sat r0.x, r2, r0
mov_pp r0.y, r1.x
add r0.x, -r0, c22.y
mov_pp r1.xyz, c5
mul_pp r0.x, r0, r0.y
mad_pp r3.x, r2.w, c5.w, -r2.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r3.x, r2
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 136 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_SunsetColor]
Float 80 [_OceanRadius]
Float 84 [_SphereRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmonkoonmmkfdmmjcfhpbjeffpdhgiheeabaaaaaadmbcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdebbaaaaeaaaaaaaenaeaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaagaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaahaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaahaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
adaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaaegbcbaiaebaaaaaa
aeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaapcaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaa
agijcaaaabaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaa
aeaaaaaafgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaa
adaaaaaaegiicaaaaaaaaaaaaeaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 128
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
VectorHalf 56 [_SunsetColor] 4
Float 64 [_OceanRadius]
Float 68 [_SphereRadius]
Float 72 [_DensityFactorA]
Float 76 [_DensityFactorB]
Float 80 [_DensityFactorC]
Float 84 [_DensityFactorD]
Float 88 [_DensityFactorE]
Float 92 [_Scale]
Float 96 [_Visibility]
Float 100 [_DensityVisibilityBase]
Float 104 [_DensityVisibilityPow]
Float 108 [_DensityVisibilityOffset]
Float 112 [_DensityCutoffBase]
Float 116 [_DensityCutoffPow]
Float 120 [_DensityCutoffOffset]
Float 124 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(0)]], sampler _mtlsmp__CameraDepthTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half tmpvar_37;
  tmpvar_37 = max ((half)0.0, ((_mtl_u._LightColor0.w * 
    (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0))
  ) * (half)2.0));
  float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_38));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, (half)0.0, (half)1.0)
  ), clamp (tmpvar_37, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_40;
  tmpvar_40 = half((1.0 - tmpvar_39));
  half tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v3, r1
dp3 r3.w, v3, v3
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.y, r1.w, c22, c22.x
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.y
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.x, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.x, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4.y, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.x, r0
mad r0.y, r4, r0.z, r4.x
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v2, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mov r0.x, r3
mul r4.z, r4, c14.x
mul r0.z, r4, r0.y
mul_sat r0.y, r0.x, c21.x
mul r0.y, r0, r0.z
dp4_pp r0.x, c2, c2
mad_sat r3.w, r5.x, c23.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c2
mul r3.xyz, r4.w, -v3
dp3 r3.y, r0, r3
dp3_pp r0.w, r1, r0
mov_pp_sat r3.x, r3.y
mov_pp_sat r3.z, r0.w
add_pp r3.z, r3.x, r3
mul_pp r3.x, r3.w, c4.w
mul_pp r3.w, r3.z, c3
mov r3.z, c13.x
mad r3.z, c7.x, r3, -r2.w
mul_pp r3.w, r3, c23.z
max_pp_sat r2.w, r3, c22.x
cmp r3.w, r3.z, c22.y, c22.x
cmp r3.z, r1.w, c22.x, c22.y
cmp r1.w, -r1, c22.x, c22.y
add r1.w, r1, -r3.z
mul r3.z, r4.y, r3.w
mul r1.w, r1, r4.x
add_pp r3.z, -r3, c22.y
mad r1.xyz, r1.w, r1, c0
add r1.xyz, r1, -r2
mul_pp r1.w, r3.z, r2
mad_pp r3.w, -r3.z, r2, r2
mad_pp r2.x, r3.y, r3.w, r1.w
mul_pp r2.w, r3.x, r2.x
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r1
pow_pp_sat r1, r0.w, c22.z
dp3_sat r0.x, r2, r0
mov_pp r0.y, r1.x
add r0.x, -r0, c22.y
mov_pp r1.xyz, c5
mul_pp r0.x, r0, r0.y
mad_pp r3.x, r2.w, c5.w, -r2.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r3.x, r2
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 136 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_SunsetColor]
Float 80 [_OceanRadius]
Float 84 [_SphereRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmonkoonmmkfdmmjcfhpbjeffpdhgiheeabaaaaaadmbcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdebbaaaaeaaaaaaaenaeaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaagaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaahaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaahaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
adaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaaegbcbaiaebaaaaaa
aeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaapcaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaa
agijcaaaabaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaa
aeaaaaaafgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaa
adaaaaaaegiicaaaaaaaaaaaaeaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 128
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
VectorHalf 56 [_SunsetColor] 4
Float 64 [_OceanRadius]
Float 68 [_SphereRadius]
Float 72 [_DensityFactorA]
Float 76 [_DensityFactorB]
Float 80 [_DensityFactorC]
Float 84 [_DensityFactorD]
Float 88 [_DensityFactorE]
Float 92 [_Scale]
Float 96 [_Visibility]
Float 100 [_DensityVisibilityBase]
Float 104 [_DensityVisibilityPow]
Float 108 [_DensityVisibilityOffset]
Float 112 [_DensityCutoffBase]
Float 116 [_DensityCutoffPow]
Float 120 [_DensityCutoffOffset]
Float 124 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(0)]], sampler _mtlsmp__CameraDepthTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half tmpvar_37;
  tmpvar_37 = max ((half)0.0, ((_mtl_u._LightColor0.w * 
    (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0))
  ) * (half)2.0));
  float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_38));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, (half)0.0, (half)1.0)
  ), clamp (tmpvar_37, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_40;
  tmpvar_40 = half((1.0 - tmpvar_39));
  half tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v3, r1
dp3 r3.w, v3, v3
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.y, r1.w, c22, c22.x
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.y
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.x, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.x, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4.y, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.x, r0
mad r0.y, r4, r0.z, r4.x
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v2, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mov r0.x, r3
mul r4.z, r4, c14.x
mul r0.z, r4, r0.y
mul_sat r0.y, r0.x, c21.x
mul r0.y, r0, r0.z
dp4_pp r0.x, c2, c2
mad_sat r3.w, r5.x, c23.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, c2
mul r3.xyz, r4.w, -v3
dp3 r3.y, r0, r3
dp3_pp r0.w, r1, r0
mov_pp_sat r3.x, r3.y
mov_pp_sat r3.z, r0.w
add_pp r3.z, r3.x, r3
mul_pp r3.x, r3.w, c4.w
mul_pp r3.w, r3.z, c3
mov r3.z, c13.x
mad r3.z, c7.x, r3, -r2.w
mul_pp r3.w, r3, c23.z
max_pp_sat r2.w, r3, c22.x
cmp r3.w, r3.z, c22.y, c22.x
cmp r3.z, r1.w, c22.x, c22.y
cmp r1.w, -r1, c22.x, c22.y
add r1.w, r1, -r3.z
mul r3.z, r4.y, r3.w
mul r1.w, r1, r4.x
add_pp r3.z, -r3, c22.y
mad r1.xyz, r1.w, r1, c0
add r1.xyz, r1, -r2
mul_pp r1.w, r3.z, r2
mad_pp r3.w, -r3.z, r2, r2
mad_pp r2.x, r3.y, r3.w, r1.w
mul_pp r2.w, r3.x, r2.x
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r1
pow_pp_sat r1, r0.w, c22.z
dp3_sat r0.x, r2, r0
mov_pp r0.y, r1.x
add r0.x, -r0, c22.y
mov_pp r1.xyz, c5
mul_pp r0.x, r0, r0.y
mad_pp r3.x, r2.w, c5.w, -r2.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r3.x, r2
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 136 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_SunsetColor]
Float 80 [_OceanRadius]
Float 84 [_SphereRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedmonkoonmmkfdmmjcfhpbjeffpdhgiheeabaaaaaadmbcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdebbaaaaeaaaaaaaenaeaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaagaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaahaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaahaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaahaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
adaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaaegbcbaiaebaaaaaa
aeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaaapcaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaa
agijcaaaabaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaa
aeaaaaaafgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaa
adaaaaaaegiicaaaaaaaaaaaaeaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 162 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 0
ConstBuffer "$Globals" 128
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
VectorHalf 40 [_LightColor0] 4
VectorHalf 48 [_Color] 4
VectorHalf 56 [_SunsetColor] 4
Float 64 [_OceanRadius]
Float 68 [_SphereRadius]
Float 72 [_DensityFactorA]
Float 76 [_DensityFactorB]
Float 80 [_DensityFactorC]
Float 84 [_DensityFactorD]
Float 88 [_DensityFactorE]
Float 92 [_Scale]
Float 96 [_Visibility]
Float 100 [_DensityVisibilityBase]
Float 104 [_DensityVisibilityPow]
Float 108 [_DensityVisibilityOffset]
Float 112 [_DensityCutoffBase]
Float 116 [_DensityCutoffPow]
Float 120 [_DensityCutoffOffset]
Float 124 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(0)]], sampler _mtlsmp__CameraDepthTexture [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half tmpvar_37;
  tmpvar_37 = max ((half)0.0, ((_mtl_u._LightColor0.w * 
    (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0))
  ) * (half)2.0));
  float tmpvar_38;
  tmpvar_38 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_38));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_37, (half)0.0, (half)1.0)
  ), clamp (tmpvar_37, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_39;
  tmpvar_39 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_40;
  tmpvar_40 = half((1.0 - tmpvar_39));
  half tmpvar_41;
  tmpvar_41 = (tmpvar_40 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_41)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_41);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v4, r1
dp3 r3.w, v4, v4
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.x, r1.w, c22.y, c22
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.x
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.y, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.y, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.y, r0
mad r0.y, r4.x, r0.z, r4
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4.x
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v3, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mul r4.z, r4, c14.x
mov r0.x, r3
mul r0.y, r4.z, r0
mul_sat r0.x, r0, c21
mul r0.y, r0.x, r0
mad_sat r0.y, r5.x, c23.x, r0
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, c2
mul_pp r0.w, r0.y, c4
mul r0.xyz, r4.w, -v4
dp3 r4.z, r3, r0
dp3_pp r3.w, r1, r3
mov_pp_sat r0.x, r4.z
mov_pp_sat r0.y, r3.w
add_pp r0.y, r0.x, r0
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
mov r0.x, c13
mad r0.x, c7, r0, -r2.w
cmp r0.z, r0.x, c22.y, c22.x
mul_pp r0.y, r0, c23.z
max_pp_sat r2.w, r0.y, c22.x
cmp r0.y, r1.w, c22.x, c22
cmp r0.x, -r1.w, c22, c22.y
add r0.x, r0, -r0.y
mul r0.y, r4.x, r0.z
add_pp r1.w, -r0.y, c22.y
mul r0.x, r0, r4.y
mad r0.xyz, r0.x, r1, c0
add r0.xyz, r0, -r2
mul_pp r1.x, r1.w, r2.w
mad_pp r4.x, -r1.w, r2.w, r2.w
mad_pp r1.y, r4.z, r4.x, r1.x
mul_pp r1.w, r0, r1.y
dp3 r1.x, r0, r0
rsq r0.w, r1.x
mul r1.xyz, r0.w, r0
pow_pp_sat r0, r3.w, c22.z
dp3_sat r0.y, r1, r3
add r0.y, -r0, c22
mov_pp r1.xyz, c5
mul_pp r0.x, r0.y, r0
mad_pp r2.x, r1.w, c5.w, -r1.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r2.x, r1
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 138 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 240
Vector 80 [_LightColor0]
Vector 112 [_Color]
Vector 128 [_SunsetColor]
Float 144 [_OceanRadius]
Float 148 [_SphereRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedoholjjpmoeolgnjgdbmiadfbpihemednabaaaaaanibcaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclibbaaaa
eaaaaaaagoaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaa
ckiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaalaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaaoaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaamaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaanaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegbcbaiaebaaaaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaacaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapcaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaaagijcaaa
abaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaaeaaaaaa
fgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaaahaaaaaa
egiicaaaaaaaaaaaaiaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v4, r1
dp3 r3.w, v4, v4
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.x, r1.w, c22.y, c22
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.x
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.y, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.y, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.y, r0
mad r0.y, r4.x, r0.z, r4
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4.x
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v3, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mul r4.z, r4, c14.x
mov r0.x, r3
mul r0.y, r4.z, r0
mul_sat r0.x, r0, c21
mul r0.y, r0.x, r0
mad_sat r0.y, r5.x, c23.x, r0
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, c2
mul_pp r0.w, r0.y, c4
mul r0.xyz, r4.w, -v4
dp3 r4.z, r3, r0
dp3_pp r3.w, r1, r3
mov_pp_sat r0.x, r4.z
mov_pp_sat r0.y, r3.w
add_pp r0.y, r0.x, r0
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
mov r0.x, c13
mad r0.x, c7, r0, -r2.w
cmp r0.z, r0.x, c22.y, c22.x
mul_pp r0.y, r0, c23.z
max_pp_sat r2.w, r0.y, c22.x
cmp r0.y, r1.w, c22.x, c22
cmp r0.x, -r1.w, c22, c22.y
add r0.x, r0, -r0.y
mul r0.y, r4.x, r0.z
add_pp r1.w, -r0.y, c22.y
mul r0.x, r0, r4.y
mad r0.xyz, r0.x, r1, c0
add r0.xyz, r0, -r2
mul_pp r1.x, r1.w, r2.w
mad_pp r4.x, -r1.w, r2.w, r2.w
mad_pp r1.y, r4.z, r4.x, r1.x
mul_pp r1.w, r0, r1.y
dp3 r1.x, r0, r0
rsq r0.w, r1.x
mul r1.xyz, r0.w, r0
pow_pp_sat r0, r3.w, c22.z
dp3_sat r0.y, r1, r3
add r0.y, -r0, c22
mov_pp r1.xyz, c5
mul_pp r0.x, r0.y, r0
mad_pp r2.x, r1.w, c5.w, -r1.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r2.x, r1
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 138 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 240
Vector 80 [_LightColor0]
Vector 112 [_Color]
Vector 128 [_SunsetColor]
Float 144 [_OceanRadius]
Float 148 [_SphereRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedoholjjpmoeolgnjgdbmiadfbpihemednabaaaaaanibcaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclibbaaaa
eaaaaaaagoaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaa
ckiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaalaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaaoaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaamaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaanaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegbcbaiaebaaaaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaacaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapcaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaaagijcaaa
abaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaaeaaaaaa
fgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaaahaaaaaa
egiicaaaaaaaaaaaaiaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 168 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_SunsetColor]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
Float 8 [_DensityFactorA]
Float 9 [_DensityFactorB]
Float 10 [_DensityFactorC]
Float 11 [_DensityFactorD]
Float 12 [_DensityFactorE]
Float 13 [_Scale]
Float 14 [_Visibility]
Float 15 [_DensityVisibilityBase]
Float 16 [_DensityVisibilityPow]
Float 17 [_DensityVisibilityOffset]
Float 18 [_DensityCutoffBase]
Float 19 [_DensityCutoffPow]
Float 20 [_DensityCutoffOffset]
Float 21 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c22, 0.00000000, 1.00000000, 5.00000000, 2.71828175
def c23, -2.00000000, 0.50000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.w, v4, r1
dp3 r3.w, v4, v4
mad r0.x, -r1.w, r1.w, r3.w
mov r0.y, c13.x
rsq r0.x, r0.x
cmp r4.x, r1.w, c22.y, c22
rcp r2.w, r0.x
mul r0.z, c6.x, r0.y
add r0.x, -r2.w, r0.z
mul r0.y, r2.w, r2.w
cmp r0.x, r0, c22.y, c22
mul r0.w, r0.x, r4.x
texldp r0.x, v0, s0
rcp r3.x, c11.x
rcp r5.x, c10.x
mad r0.z, r0, r0, -r0.y
mad r2.x, r0, c1.z, c1.w
rsq r0.x, r0.z
rcp r0.z, r2.x
rcp r0.x, r0.x
mul r0.z, r0, c13.x
add r0.x, r1.w, -r0
add r2.x, r0, -r0.z
mad r0.w, r0, r2.x, r0.z
min r4.z, r0.w, r0
add r0.x, -r0.y, r3.w
rsq r0.x, r0.x
rcp r4.y, r0.x
add r2.y, -r1.w, r4.z
mul r2.x, r0.y, c9
add r0.z, r4.y, r4
max r0.x, r2.y, c22
add r0.x, r0, -r0.z
mad r0.x, r0, r4, r0.z
mul r0.x, r0, r0
mad r0.x, r0, c10, r2
rsq r0.x, r0.x
rcp r2.z, r0.x
add r0.x, r2.z, c12
mul r3.y, -r0.x, r3.x
pow r0, c22.w, r3.y
mov r0.y, c8.x
mul r4.w, c11.x, r0.y
add r0.z, r2, c11.x
mul r0.y, r4.w, r0.z
max r0.z, -r2.y, c22.x
mul r2.y, r0, r0.x
rsq r0.x, r2.x
rcp r3.y, r0.x
add r0.x, r3.y, c12
add r0.z, -r4.y, r0
mad r0.y, r4.x, r0.z, r4
mul r0.y, r0, r0
mad r0.y, r0, c10.x, r2.x
rsq r0.y, r0.y
mul r3.z, r3.x, -r0.x
rcp r2.z, r0.y
pow r0, c22.w, r3.z
add r0.y, r3, c11.x
mul r0.y, r4.w, r0
mul r0.x, r0.y, r0
mul r0.x, r0, r5
mad r5.y, r2, r5.x, -r0.x
add r0.y, r2.z, c12.x
mul r3.y, r3.x, -r0
pow r0, c22.w, r3.y
add r2.y, r2.z, c11.x
mul r0.z, r4.w, r2.y
mul r0.y, r1.w, r4.x
mov r0.w, r0.x
mul r0.x, r0.y, r0.y
mul r0.y, r0.z, r0.w
mad r0.x, r0, c10, r2
rsq r0.w, r0.x
mul r5.w, r5.x, r0.y
mad r0.xyz, r1, r4.z, c0
rcp r5.z, r0.w
add r0.w, r5.z, c12.x
add r2.xyz, v3, -c0
mul r2.xyz, r2, c13.x
add r2.xyz, r2, c0
mul r6.x, r3, -r0.w
add r3.xyz, -r2, r0
pow r0, c22.w, r6.x
dp3 r0.w, r3, r3
mov r0.z, r0.x
add r0.y, r5.z, c11.x
mul r0.x, r4.w, r0.y
mul r0.x, r0, r0.z
mad r0.x, r5, r0, -r5.w
rsq r0.y, r0.w
rsq r4.w, r3.w
rcp r0.z, r0.y
rcp r0.y, r4.w
add r0.z, r0.y, r0
add r5.x, r5.y, r0
mul r0.x, r0.z, c23.y
add r0.z, r0.x, c17.x
add r0.x, r0.y, c20
mul r3.x, r0.z, -c16
mul r5.y, r0.x, -c19.x
pow r0, c15.x, r3.x
pow r3, c18.x, r5.y
mov r0.y, r0.x
mul r4.z, r4, c14.x
mov r0.x, r3
mul r0.y, r4.z, r0
mul_sat r0.x, r0, c21
mul r0.y, r0.x, r0
mad_sat r0.y, r5.x, c23.x, r0
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, c2
mul_pp r0.w, r0.y, c4
mul r0.xyz, r4.w, -v4
dp3 r4.z, r3, r0
dp3_pp r3.w, r1, r3
mov_pp_sat r0.x, r4.z
mov_pp_sat r0.y, r3.w
add_pp r0.y, r0.x, r0
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
mov r0.x, c13
mad r0.x, c7, r0, -r2.w
cmp r0.z, r0.x, c22.y, c22.x
mul_pp r0.y, r0, c23.z
max_pp_sat r2.w, r0.y, c22.x
cmp r0.y, r1.w, c22.x, c22
cmp r0.x, -r1.w, c22, c22.y
add r0.x, r0, -r0.y
mul r0.y, r4.x, r0.z
add_pp r1.w, -r0.y, c22.y
mul r0.x, r0, r4.y
mad r0.xyz, r0.x, r1, c0
add r0.xyz, r0, -r2
mul_pp r1.x, r1.w, r2.w
mad_pp r4.x, -r1.w, r2.w, r2.w
mad_pp r1.y, r4.z, r4.x, r1.x
mul_pp r1.w, r0, r1.y
dp3 r1.x, r0, r0
rsq r0.w, r1.x
mul r1.xyz, r0.w, r0
pow_pp_sat r0, r3.w, c22.z
dp3_sat r0.y, r1, r3
add r0.y, -r0, c22
mov_pp r1.xyz, c5
mul_pp r0.x, r0.y, r0
mad_pp r2.x, r1.w, c5.w, -r1.w
add_pp r1.xyz, -c4, r1
mad_pp oC0.w, r0.x, r2.x, r1
mad_pp oC0.xyz, r0.x, r1, c4
"
}
SubProgram "d3d11 " {
// Stats: 138 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 240
Vector 80 [_LightColor0]
Vector 112 [_Color]
Vector 128 [_SunsetColor]
Float 144 [_OceanRadius]
Float 148 [_SphereRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedoholjjpmoeolgnjgdbmiadfbpihemednabaaaaaanibcaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclibbaaaa
eaaaaaaagoaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaajmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaabaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaeeaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaajgahbaaaabaaaaaa
dcaaaaakccaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
bnaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaakmcaabaaa
aaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
diaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaa
elaaaaafkcaabaaaacaaaaaafganbaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaa
fgafbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaajbcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaa
ckiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaa
kgakbaaaaaaaaaaakgilcaaaaaaaaaaaalaaaaaaaoaaaaajecaabaaaaaaaaaaa
ckaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaa
aoaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaimcaabaaaacaaaaaa
kgakbaaaacaaaaaakgiocaaaaaaaaaaaalaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaigcaabaaaadaaaaaakgakbaaaaaaaaaaakgilcaaa
aaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaoaaaaajccaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaajicaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaadiaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
cpaaaaagecaabaaaacaaaaaabkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaaoaaaaaadcaaaaakhcaabaaaadaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaajhcaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaaeaaaaaa
agiacaaaaaaaaaaaamaaaaaaegacbaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaanaaaaaadiaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagecaabaaa
acaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaacaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
baaaaaajccaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegbcbaiaebaaaaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaabbaaaaajccaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaafaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadgcaaaafecaabaaaaaaaaaaabkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaafaaaaaadgcaaaaf
ecaabaaaacaaaaaaakaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaacaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapcaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakocaabaaaabaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaaagijcaaa
abaaaaaaaeaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaaeaaaaaa
fgaobaaaabaaaaaabaaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaakgakbaaaaaaaaaaafgaobaaaabaaaaaabacaaaahecaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaaklcaabaaaaaaaaaaaegiicaiaebaaaaaaaaaaaaaaahaaaaaa
egiicaaaaaaaaaaaaiaaaaaadcaaaaakhccabaaaaaaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 152
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
Vector 48 [_LightShadowData]
VectorHalf 64 [_LightColor0] 4
VectorHalf 72 [_Color] 4
VectorHalf 80 [_SunsetColor] 4
Float 88 [_OceanRadius]
Float 92 [_SphereRadius]
Float 96 [_DensityFactorA]
Float 100 [_DensityFactorB]
Float 104 [_DensityFactorC]
Float 108 [_DensityFactorD]
Float 112 [_DensityFactorE]
Float 116 [_Scale]
Float 120 [_Visibility]
Float 124 [_DensityVisibilityBase]
Float 128 [_DensityVisibilityPow]
Float 132 [_DensityVisibilityOffset]
Float 136 [_DensityCutoffBase]
Float 140 [_DensityCutoffPow]
Float 144 [_DensityCutoffOffset]
Float 148 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(1)]], sampler _mtlsmp__CameraDepthTexture [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half shadow_37;
  half tmpvar_38;
  tmpvar_38 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_39;
  tmpvar_39 = tmpvar_38;
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._LightShadowData.x + ((float)tmpvar_39 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_37 = half(tmpvar_40);
  half tmpvar_41;
  tmpvar_41 = max ((half)0.0, ((
    (_mtl_u._LightColor0.w * (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0)))
   * (half)2.0) * shadow_37));
  float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_42));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, (half)0.0, (half)1.0)
  ), clamp (tmpvar_41, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_44;
  tmpvar_44 = half((1.0 - tmpvar_43));
  half tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "WORLD_SPACE_ON" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 152
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
Vector 48 [_LightShadowData]
VectorHalf 64 [_LightColor0] 4
VectorHalf 72 [_Color] 4
VectorHalf 80 [_SunsetColor] 4
Float 88 [_OceanRadius]
Float 92 [_SphereRadius]
Float 96 [_DensityFactorA]
Float 100 [_DensityFactorB]
Float 104 [_DensityFactorC]
Float 108 [_DensityFactorD]
Float 112 [_DensityFactorE]
Float 116 [_Scale]
Float 120 [_Visibility]
Float 124 [_DensityVisibilityBase]
Float 128 [_DensityVisibilityPow]
Float 132 [_DensityVisibilityOffset]
Float 136 [_DensityCutoffBase]
Float 140 [_DensityCutoffPow]
Float 144 [_DensityCutoffOffset]
Float 148 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(1)]], sampler _mtlsmp__CameraDepthTexture [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half shadow_37;
  half tmpvar_38;
  tmpvar_38 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_39;
  tmpvar_39 = tmpvar_38;
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._LightShadowData.x + ((float)tmpvar_39 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_37 = half(tmpvar_40);
  half tmpvar_41;
  tmpvar_41 = max ((half)0.0, ((
    (_mtl_u._LightColor0.w * (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0)))
   * (half)2.0) * shadow_37));
  float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_42));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, (half)0.0, (half)1.0)
  ), clamp (tmpvar_41, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_44;
  tmpvar_44 = half((1.0 - tmpvar_43));
  half tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 166 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "WORLD_SPACE_ON" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 152
Vector 0 [_WorldSpaceCameraPos] 3
Vector 16 [_ZBufferParams]
VectorHalf 32 [_WorldSpaceLightPos0] 4
Vector 48 [_LightShadowData]
VectorHalf 64 [_LightColor0] 4
VectorHalf 72 [_Color] 4
VectorHalf 80 [_SunsetColor] 4
Float 88 [_OceanRadius]
Float 92 [_SphereRadius]
Float 96 [_DensityFactorA]
Float 100 [_DensityFactorB]
Float 104 [_DensityFactorC]
Float 108 [_DensityFactorD]
Float 112 [_DensityFactorE]
Float 116 [_Scale]
Float 120 [_Visibility]
Float 124 [_DensityVisibilityBase]
Float 128 [_DensityVisibilityPow]
Float 132 [_DensityVisibilityOffset]
Float 136 [_DensityCutoffBase]
Float 140 [_DensityCutoffPow]
Float 144 [_DensityCutoffOffset]
Float 148 [_DensityCutoffScale]
"metal_fs
#include <metal_stdlib>
using namespace metal;
constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::less);
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  float4 xlv_TEXCOORD2;
  float3 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float4 _ZBufferParams;
  half4 _WorldSpaceLightPos0;
  float4 _LightShadowData;
  half4 _LightColor0;
  half4 _Color;
  half4 _SunsetColor;
  float _OceanRadius;
  float _SphereRadius;
  float _DensityFactorA;
  float _DensityFactorB;
  float _DensityFactorC;
  float _DensityFactorD;
  float _DensityFactorE;
  float _Scale;
  float _Visibility;
  float _DensityVisibilityBase;
  float _DensityVisibilityPow;
  float _DensityVisibilityOffset;
  float _DensityCutoffBase;
  float _DensityCutoffPow;
  float _DensityCutoffOffset;
  float _DensityCutoffScale;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   depth2d<float> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _CameraDepthTexture [[texture(1)]], sampler _mtlsmp__CameraDepthTexture [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half NdotL_2;
  half3 lightDirection_3;
  half bodyCheck_4;
  half sphereCheck_5;
  half3 worldDir_6;
  float depth_7;
  half4 color_8;
  color_8 = _mtl_u._Color;
  half tmpvar_9;
  tmpvar_9 = _CameraDepthTexture.sample(_mtlsmp__CameraDepthTexture, ((float2)(_mtl_i.xlv_TEXCOORD0).xy / (float)(_mtl_i.xlv_TEXCOORD0).w)).x;
  depth_7 = float(tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = ((1.0/((
    (_mtl_u._ZBufferParams.z * depth_7)
   + _mtl_u._ZBufferParams.w))) * _mtl_u._Scale);
  float3 tmpvar_11;
  tmpvar_11 = normalize((_mtl_i.xlv_TEXCOORD1 - _mtl_u._WorldSpaceCameraPos));
  worldDir_6 = half3(tmpvar_11);
  float tmpvar_12;
  tmpvar_12 = dot (_mtl_i.xlv_TEXCOORD5, (float3)worldDir_6);
  float tmpvar_13;
  float cse_14;
  cse_14 = dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5);
  tmpvar_13 = sqrt((cse_14 - (tmpvar_12 * tmpvar_12)));
  float tmpvar_15;
  tmpvar_15 = pow (tmpvar_13, 2.0);
  float tmpvar_16;
  tmpvar_16 = sqrt((cse_14 - tmpvar_15));
  float tmpvar_17;
  tmpvar_17 = (_mtl_u._Scale * _mtl_u._OceanRadius);
  float tmpvar_18;
  tmpvar_18 = (float((tmpvar_17 >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  sphereCheck_5 = half(tmpvar_18);
  float tmpvar_19;
  tmpvar_19 = (float((
    (_mtl_u._Scale * _mtl_u._SphereRadius)
   >= tmpvar_13)) * float((tmpvar_12 >= 0.0)));
  bodyCheck_4 = half(tmpvar_19);
  float tmpvar_20;
  tmpvar_20 = min (mix (tmpvar_10, (tmpvar_12 - 
    sqrt(((tmpvar_17 * tmpvar_17) - tmpvar_15))
  ), (float)sphereCheck_5), tmpvar_10);
  float tmpvar_21;
  tmpvar_21 = sqrt(cse_14);
  float3 tmpvar_22;
  tmpvar_22 = ((_mtl_u._Scale * (_mtl_i.xlv_TEXCOORD4 - _mtl_u._WorldSpaceCameraPos)) + _mtl_u._WorldSpaceCameraPos);
  float3 x_23;
  x_23 = ((_mtl_u._WorldSpaceCameraPos + (tmpvar_20 * (float3)worldDir_6)) - tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_12 >= 0.0));
  sphereCheck_5 = half(tmpvar_24);
  float tmpvar_25;
  tmpvar_25 = mix ((tmpvar_20 + tmpvar_16), max (0.0, (tmpvar_20 - tmpvar_12)), (float)sphereCheck_5);
  float tmpvar_26;
  tmpvar_26 = ((float)sphereCheck_5 * tmpvar_12);
  float tmpvar_27;
  tmpvar_27 = mix (tmpvar_16, max (0.0, (tmpvar_12 - tmpvar_20)), (float)sphereCheck_5);
  float tmpvar_28;
  tmpvar_28 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_25 * tmpvar_25)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_29;
  tmpvar_29 = sqrt((_mtl_u._DensityFactorB * (tmpvar_13 * tmpvar_13)));
  float tmpvar_30;
  tmpvar_30 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_26 * tmpvar_26)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_31;
  tmpvar_31 = sqrt(((_mtl_u._DensityFactorC * 
    (tmpvar_27 * tmpvar_27)
  ) + (_mtl_u._DensityFactorB * 
    (tmpvar_13 * tmpvar_13)
  )));
  float tmpvar_32;
  float cse_33;
  cse_33 = (-2.0 * _mtl_u._DensityFactorA);
  tmpvar_32 = (((
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_28 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_28 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_29 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_29 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  ) + (
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_30 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_30 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
   - 
    ((((cse_33 * _mtl_u._DensityFactorD) * (tmpvar_31 + _mtl_u._DensityFactorD)) * pow (2.71828, (
      -((tmpvar_31 + _mtl_u._DensityFactorE))
     / _mtl_u._DensityFactorD))) / _mtl_u._DensityFactorC)
  )) + (clamp (
    (_mtl_u._DensityCutoffScale * pow (_mtl_u._DensityCutoffBase, (-(_mtl_u._DensityCutoffPow) * (tmpvar_21 + _mtl_u._DensityCutoffOffset))))
  , 0.0, 1.0) * (
    (_mtl_u._Visibility * tmpvar_20)
   * 
    pow (_mtl_u._DensityVisibilityBase, (-(_mtl_u._DensityVisibilityPow) * ((0.5 * 
      (tmpvar_21 + sqrt(dot (x_23, x_23)))
    ) + _mtl_u._DensityVisibilityOffset)))
  )));
  depth_7 = tmpvar_32;
  half3 tmpvar_34;
  tmpvar_34 = normalize(_mtl_u._WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_34;
  half tmpvar_35;
  tmpvar_35 = dot (worldDir_6, lightDirection_3);
  float tmpvar_36;
  tmpvar_36 = dot (normalize(-(_mtl_i.xlv_TEXCOORD5)), (float3)lightDirection_3);
  NdotL_2 = half(tmpvar_36);
  half shadow_37;
  half tmpvar_38;
  tmpvar_38 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, (float2)(_mtl_i.xlv_TEXCOORD2.xyz).xy, (float)(_mtl_i.xlv_TEXCOORD2.xyz).z);
  half tmpvar_39;
  tmpvar_39 = tmpvar_38;
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._LightShadowData.x + ((float)tmpvar_39 * (1.0 - _mtl_u._LightShadowData.x)));
  shadow_37 = half(tmpvar_40);
  half tmpvar_41;
  tmpvar_41 = max ((half)0.0, ((
    (_mtl_u._LightColor0.w * (clamp (NdotL_2, (half)0.0, (half)1.0) + clamp (tmpvar_35, (half)0.0, (half)1.0)))
   * (half)2.0) * shadow_37));
  float tmpvar_42;
  tmpvar_42 = clamp (tmpvar_32, 0.0, 1.0);
  color_8.w = ((half)((float)color_8.w * tmpvar_42));
  color_8.w = (color_8.w * mix ((
    ((half)1.0 - bodyCheck_4)
   * 
    clamp (tmpvar_41, (half)0.0, (half)1.0)
  ), clamp (tmpvar_41, (half)0.0, (half)1.0), NdotL_2));
  float tmpvar_43;
  tmpvar_43 = clamp (dot (normalize(
    ((_mtl_u._WorldSpaceCameraPos + ((
      sign(tmpvar_12)
     * tmpvar_16) * (float3)worldDir_6)) - tmpvar_22)
  ), (float3)lightDirection_3), 0.0, 1.0);
  half tmpvar_44;
  tmpvar_44 = half((1.0 - tmpvar_43));
  half tmpvar_45;
  tmpvar_45 = (tmpvar_44 * clamp (pow (tmpvar_35, (half)5.0), (half)0.0, (half)1.0));
  color_8.xyz = mix (_mtl_u._Color, _mtl_u._SunsetColor, half4(tmpvar_45)).xyz;
  color_8.w = mix (color_8.w, (color_8.w * _mtl_u._SunsetColor.w), tmpvar_45);
  tmpvar_1 = color_8;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
}
 }
}
}