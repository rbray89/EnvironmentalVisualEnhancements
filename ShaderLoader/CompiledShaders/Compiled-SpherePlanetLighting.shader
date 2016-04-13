// Compiled shader for all platforms, uncompressed size: 836.3KB

// Skipping shader variants that would not be included into build of current scene.

Shader "EVE/PlanetLight" {
Properties {
 _Color ("Color Tint", Color) = (1,1,1,1)
 _SpecularColor ("Specular tint", Color) = (1,1,1,1)
 _SpecularPower ("Shininess", Float) = 0.078125
 _PlanetOpacity ("PlanetOpacity", Float) = 1
 _SunPos ("_SunPos", Vector) = (0,0,0,1)
 _SunRadius ("_SunRadius", Float) = 1
 _bPos ("_bPos", Vector) = (0,0,0,1)
 _bRadius ("_bRadius", Float) = 1
}
SubShader { 
 Tags { "QUEUE"="Geometry+2" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 //        gles : 205 math
 //       metal : 2 math
 //      opengl : 205 math
 // Stats for Fragment shader:
 //       d3d11 : 155 math
 //        d3d9 : 163 math
 //       metal : 205 math
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry+2" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="Transparent" }
  Lighting On
  ZWrite Off
  Blend Zero SrcAlpha
  GpuProgramID 43729
Program "vp" {
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE2_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mat4 _ShadowBodies;
uniform float _SunRadius;
uniform vec3 _SunPos;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  vec4 v_2;
  v_2.x = _ShadowBodies[0].x;
  v_2.y = _ShadowBodies[1].x;
  v_2.z = _ShadowBodies[2].x;
  float tmpvar_3;
  tmpvar_3 = _ShadowBodies[3].x;
  v_2.w = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_SunPos - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = (3.141593 * (tmpvar_3 * tmpvar_3));
  vec3 tmpvar_6;
  tmpvar_6 = (v_2.xyz - xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(tmpvar_4));
  float tmpvar_8;
  tmpvar_8 = (_SunRadius * (tmpvar_7 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_9;
  tmpvar_9 = (3.141593 * (tmpvar_8 * tmpvar_8));
  float x_10;
  x_10 = ((2.0 * clamp (
    (((tmpvar_3 + tmpvar_8) - sqrt((
      dot (tmpvar_6, tmpvar_6)
     - 
      (tmpvar_7 * tmpvar_7)
    ))) / (2.0 * min (tmpvar_3, tmpvar_8)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_11;
  v_11.x = _ShadowBodies[0].y;
  v_11.y = _ShadowBodies[1].y;
  v_11.z = _ShadowBodies[2].y;
  float tmpvar_12;
  tmpvar_12 = _ShadowBodies[3].y;
  v_11.w = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (3.141593 * (tmpvar_12 * tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (v_11.xyz - xlv_TEXCOORD0);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, normalize(tmpvar_4));
  float tmpvar_16;
  tmpvar_16 = (_SunRadius * (tmpvar_15 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_16 * tmpvar_16));
  float x_18;
  x_18 = ((2.0 * clamp (
    (((tmpvar_12 + tmpvar_16) - sqrt((
      dot (tmpvar_14, tmpvar_14)
     - 
      (tmpvar_15 * tmpvar_15)
    ))) / (2.0 * min (tmpvar_12, tmpvar_16)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_19;
  v_19.x = _ShadowBodies[0].z;
  v_19.y = _ShadowBodies[1].z;
  v_19.z = _ShadowBodies[2].z;
  float tmpvar_20;
  tmpvar_20 = _ShadowBodies[3].z;
  v_19.w = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_22;
  tmpvar_22 = (v_19.xyz - xlv_TEXCOORD0);
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize(tmpvar_4));
  float tmpvar_24;
  tmpvar_24 = (_SunRadius * (tmpvar_23 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_25;
  tmpvar_25 = (3.141593 * (tmpvar_24 * tmpvar_24));
  float x_26;
  x_26 = ((2.0 * clamp (
    (((tmpvar_20 + tmpvar_24) - sqrt((
      dot (tmpvar_22, tmpvar_22)
     - 
      (tmpvar_23 * tmpvar_23)
    ))) / (2.0 * min (tmpvar_20, tmpvar_24)))
  , 0.0, 1.0)) - 1.0);
  vec4 v_27;
  v_27.x = _ShadowBodies[0].w;
  v_27.y = _ShadowBodies[1].w;
  v_27.z = _ShadowBodies[2].w;
  float tmpvar_28;
  tmpvar_28 = _ShadowBodies[3].w;
  v_27.w = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (3.141593 * (tmpvar_28 * tmpvar_28));
  vec3 tmpvar_30;
  tmpvar_30 = (v_27.xyz - xlv_TEXCOORD0);
  float tmpvar_31;
  tmpvar_31 = dot (tmpvar_30, normalize(tmpvar_4));
  float tmpvar_32;
  tmpvar_32 = (_SunRadius * (tmpvar_31 / sqrt(
    dot (tmpvar_4, tmpvar_4)
  )));
  float tmpvar_33;
  tmpvar_33 = (3.141593 * (tmpvar_32 * tmpvar_32));
  float x_34;
  x_34 = ((2.0 * clamp (
    (((tmpvar_28 + tmpvar_32) - sqrt((
      dot (tmpvar_30, tmpvar_30)
     - 
      (tmpvar_31 * tmpvar_31)
    ))) / (2.0 * min (tmpvar_28, tmpvar_32)))
  , 0.0, 1.0)) - 1.0);
  color_1.w = min (min (mix (1.0, 
    clamp (((tmpvar_9 - (
      ((0.3183099 * (sign(x_10) * (1.570796 - 
        (sqrt((1.0 - abs(x_10))) * (1.570796 + (abs(x_10) * (-0.2146018 + 
          (abs(x_10) * (0.08656672 + (abs(x_10) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_5)) / tmpvar_9), 0.0, 1.0)
  , 
    (float((tmpvar_7 >= tmpvar_3)) * clamp (tmpvar_5, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_17 - (
      ((0.3183099 * (sign(x_18) * (1.570796 - 
        (sqrt((1.0 - abs(x_18))) * (1.570796 + (abs(x_18) * (-0.2146018 + 
          (abs(x_18) * (0.08656672 + (abs(x_18) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_13)) / tmpvar_17), 0.0, 1.0)
  , 
    (float((tmpvar_15 >= tmpvar_12)) * clamp (tmpvar_13, 0.0, 1.0))
  )), min (mix (1.0, 
    clamp (((tmpvar_25 - (
      ((0.3183099 * (sign(x_26) * (1.570796 - 
        (sqrt((1.0 - abs(x_26))) * (1.570796 + (abs(x_26) * (-0.2146018 + 
          (abs(x_26) * (0.08656672 + (abs(x_26) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_21)) / tmpvar_25), 0.0, 1.0)
  , 
    (float((tmpvar_23 >= tmpvar_20)) * clamp (tmpvar_21, 0.0, 1.0))
  ), mix (1.0, 
    clamp (((tmpvar_33 - (
      ((0.3183099 * (sign(x_34) * (1.570796 - 
        (sqrt((1.0 - abs(x_34))) * (1.570796 + (abs(x_34) * (-0.2146018 + 
          (abs(x_34) * (0.08656672 + (abs(x_34) * -0.03102955)))
        ))))
      ))) + 0.5)
     * tmpvar_29)) / tmpvar_33), 0.0, 1.0)
  , 
    (float((tmpvar_31 >= tmpvar_28)) * clamp (tmpvar_29, 0.0, 1.0))
  )));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedbhjiiffobhidikmijjeplebicccldhpiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaapeaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeebeoehefeofeaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaaeaaaabaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
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
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
bool tb0;
vec3 t1;
vec4 t2;
vec4 t3;
vec3 t4;
float t5;
bool tb5;
float t6;
float t7;
float t8;
float t10;
bool tb10;
float t11;
float t15;
bool tb15;
float t16;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t15 = dot(t0.xyz, t0.xyz);
    t1.xyz = (-vs_TEXCOORD0.xyz) + vec3(_SunPos.x, _SunPos.y, _SunPos.z);
    t16 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t16);
    t16 = sqrt(t16);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t5 = (-t0.x) * t0.x + t15;
    t5 = sqrt(t5);
    t10 = t0.x / t16;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t15 = _SunRadius * t10 + _ShadowBodies[3].x;
    t10 = t10 * _SunRadius;
    t5 = (-t5) + t15;
    t15 = min(t10, _ShadowBodies[3].x);
    t10 = t10 * t10;
    t10 = t10 * 3.14159274;
    t15 = t15 + t15;
    t5 = t5 / t15;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 * 2.0 + -1.0;
    t15 = abs(t5) * -0.0187292993 + 0.0742610022;
    t15 = t15 * abs(t5) + -0.212114394;
    t15 = t15 * abs(t5) + 1.57072878;
    t2.x = -abs(t5) + 1.0;
    tb5 = t5<(-t5);
    t2.x = sqrt(t2.x);
    t7 = t15 * t2.x;
    t7 = t7 * -2.0 + 3.14159274;
    t5 = tb5 ? t7 : float(0.0);
    t5 = t15 * t2.x + t5;
    t5 = (-t5) + 1.57079637;
    t5 = t5 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t5 = (-t5) * t2.x + t10;
    t5 = t5 / t10;
    t5 = clamp(t5, 0.0, 1.0);
    t5 = t5 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t5 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].y;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.y * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].y;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].y);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t3.x = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t3.x = sqrt(t3.x);
    t8 = t2.x * t3.x;
    t8 = t8 * -2.0 + 3.14159274;
    t10 = tb10 ? t8 : float(0.0);
    t10 = t2.x * t3.x + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.y + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t0.x = min(t5, t0.x);
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t5 = dot(t4.xyz, t1.xyz);
    t10 = dot(t4.xyz, t4.xyz);
    t10 = (-t5) * t5 + t10;
    t10 = sqrt(t10);
    t15 = t5 / t16;
    tb5 = t5>=_ShadowBodies[3].z;
    t5 = tb5 ? 1.0 : float(0.0);
    t5 = t3.z * t5;
    t2.x = _SunRadius * t15 + _ShadowBodies[3].z;
    t15 = t15 * _SunRadius;
    t10 = (-t10) + t2.x;
    t2.x = min(t15, _ShadowBodies[3].z);
    t15 = t15 * t15;
    t15 = t15 * 3.14159274;
    t2.x = t2.x + t2.x;
    t10 = t10 / t2.x;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 * 2.0 + -1.0;
    t2.x = abs(t10) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t10) + -0.212114394;
    t2.x = t2.x * abs(t10) + 1.57072878;
    t7 = -abs(t10) + 1.0;
    tb10 = t10<(-t10);
    t7 = sqrt(t7);
    t3.x = t7 * t2.x;
    t3.x = t3.x * -2.0 + 3.14159274;
    t10 = tb10 ? t3.x : float(0.0);
    t10 = t2.x * t7 + t10;
    t10 = (-t10) + 1.57079637;
    t10 = t10 * 0.318309873 + 0.5;
    t10 = (-t10) * t2.z + t15;
    t10 = t10 / t15;
    t10 = clamp(t10, 0.0, 1.0);
    t10 = t10 + -1.0;
    t5 = t5 * t10 + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t10 = dot(t2.xyz, t1.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t15 = (-t10) * t10 + t15;
    t15 = sqrt(t15);
    t1.x = t10 / t16;
    tb10 = t10>=_ShadowBodies[3].w;
    t10 = tb10 ? 1.0 : float(0.0);
    t10 = t3.w * t10;
    t6 = _SunRadius * t1.x + _ShadowBodies[3].w;
    t1.x = t1.x * _SunRadius;
    t15 = (-t15) + t6;
    t6 = min(t1.x, _ShadowBodies[3].w);
    t1.x = t1.x * t1.x;
    t1.x = t1.x * 3.14159274;
    t6 = t6 + t6;
    t15 = t15 / t6;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 * 2.0 + -1.0;
    t6 = abs(t15) * -0.0187292993 + 0.0742610022;
    t6 = t6 * abs(t15) + -0.212114394;
    t6 = t6 * abs(t15) + 1.57072878;
    t11 = -abs(t15) + 1.0;
    tb15 = t15<(-t15);
    t11 = sqrt(t11);
    t16 = t11 * t6;
    t16 = t16 * -2.0 + 3.14159274;
    t15 = tb15 ? t16 : float(0.0);
    t15 = t6 * t11 + t15;
    t15 = (-t15) + 1.57079637;
    t15 = t15 * 0.318309873 + 0.5;
    t15 = (-t15) * t2.w + t1.x;
    t15 = t15 / t1.x;
    t15 = clamp(t15, 0.0, 1.0);
    t15 = t15 + -1.0;
    t10 = t10 * t15 + 1.0;
    t5 = min(t10, t5);
    SV_Target0.w = min(t5, t0.x);
    SV_Target0.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
SubProgram "gles " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp mat4 _ShadowBodies;
uniform highp float _SunRadius;
uniform highp vec3 _SunPos;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(1.0, 1.0, 1.0);
  highp vec4 v_3;
  v_3.x = _ShadowBodies[0].x;
  v_3.y = _ShadowBodies[1].x;
  v_3.z = _ShadowBodies[2].x;
  highp float tmpvar_4;
  tmpvar_4 = _ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_SunPos - xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  highp vec3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  highp float tmpvar_10;
  tmpvar_10 = (_SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  highp float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = _ShadowBodies[0].y;
  v_14.y = _ShadowBodies[1].y;
  v_14.z = _ShadowBodies[2].y;
  highp float tmpvar_15;
  tmpvar_15 = _ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  highp vec3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - xlv_TEXCOORD0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  highp float tmpvar_20;
  tmpvar_20 = (_SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  highp float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = _ShadowBodies[0].z;
  v_24.y = _ShadowBodies[1].z;
  v_24.z = _ShadowBodies[2].z;
  highp float tmpvar_25;
  tmpvar_25 = _ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  highp vec3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - xlv_TEXCOORD0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  highp float tmpvar_30;
  tmpvar_30 = (_SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  highp float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = tmpvar_33;
  highp vec4 v_34;
  v_34.x = _ShadowBodies[0].w;
  v_34.y = _ShadowBodies[1].w;
  v_34.z = _ShadowBodies[2].w;
  highp float tmpvar_35;
  tmpvar_35 = _ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  highp vec3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - xlv_TEXCOORD0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  highp float tmpvar_40;
  tmpvar_40 = (_SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  highp float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  highp float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  highp float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = tmpvar_43;
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
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
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec4 t16_0;
bool tb0;
highp vec3 t1;
highp vec4 t2;
highp vec4 t3;
highp vec3 t4;
mediump float t16_5;
highp float t6;
bool tb6;
highp float t7;
highp float t8;
highp float t9;
mediump float t16_11;
highp float t12;
bool tb12;
highp float t13;
highp float t18;
highp float t19;
void main()
{
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].x;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].x;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].x;
    t18 = dot(t0.xyz, t0.xyz);
    t1.xyz = vec3((-vs_TEXCOORD0.x) + _SunPos.xxyz.y, (-vs_TEXCOORD0.y) + _SunPos.xxyz.z, (-vs_TEXCOORD0.z) + float(_SunPos.z));
    t19 = dot(t1.xyz, t1.xyz);
    t2.x = inversesqrt(t19);
    t19 = sqrt(t19);
    t1.xyz = t1.xyz * t2.xxx;
    t0.x = dot(t0.xyz, t1.xyz);
    t6 = (-t0.x) * t0.x + t18;
    t6 = sqrt(t6);
    t12 = t0.x / t19;
    tb0 = t0.x>=_ShadowBodies[3].x;
    t0.x = tb0 ? 1.0 : float(0.0);
    t18 = _SunRadius * t12 + _ShadowBodies[3].x;
    t12 = t12 * _SunRadius;
    t6 = (-t6) + t18;
    t18 = min(t12, _ShadowBodies[3].x);
    t12 = t12 * t12;
    t12 = t12 * 3.14159274;
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 * 2.0 + -1.0;
    t18 = abs(t6) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t6) + -0.212114394;
    t18 = t18 * abs(t6) + 1.57072878;
    t2.x = -abs(t6) + 1.0;
    tb6 = t6<(-t6);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t6 = tb6 ? t8 : float(0.0);
    t6 = t18 * t2.x + t6;
    t6 = (-t6) + 1.57079637;
    t6 = t6 * 0.318309873 + 0.5;
    t2 = _ShadowBodies[3] * _ShadowBodies[3];
    t2 = t2 * vec4(3.14159274, 3.14159274, 3.14159274, 3.14159274);
    t6 = (-t6) * t2.x + t12;
    t6 = t6 / t12;
    t6 = clamp(t6, 0.0, 1.0);
    t6 = t6 + -1.0;
    t3 = min(t2, vec4(1.0, 1.0, 1.0, 1.0));
    t0.x = t0.x * t3.x;
    t0.x = t0.x * t6 + 1.0;
    t4.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].y;
    t4.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].y;
    t4.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].y;
    t6 = dot(t4.xyz, t1.xyz);
    t12 = dot(t4.xyz, t4.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].y;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.y * t6;
    t2.x = _SunRadius * t18 + _ShadowBodies[3].y;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t2.x;
    t2.x = min(t18, _ShadowBodies[3].y);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t2.x = t2.x + t2.x;
    t12 = t12 / t2.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t2.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t2.x = t2.x * abs(t12) + -0.212114394;
    t2.x = t2.x * abs(t12) + 1.57072878;
    t3.x = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t3.x = sqrt(t3.x);
    t9 = t2.x * t3.x;
    t9 = t9 * -2.0 + 3.14159274;
    t12 = tb12 ? t9 : float(0.0);
    t12 = t2.x * t3.x + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.y + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_5 = min(t6, t0.x);
    t0.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].z;
    t0.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].z;
    t0.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].z;
    t18 = dot(t0.xyz, t1.xyz);
    t0.x = dot(t0.xyz, t0.xyz);
    t0.x = (-t18) * t18 + t0.x;
    t0.x = sqrt(t0.x);
    t6 = t18 / t19;
    tb12 = t18>=_ShadowBodies[3].z;
    t12 = tb12 ? 1.0 : float(0.0);
    t12 = t3.z * t12;
    t18 = _SunRadius * t6 + _ShadowBodies[3].z;
    t6 = t6 * _SunRadius;
    t0.x = (-t0.x) + t18;
    t18 = min(t6, _ShadowBodies[3].z);
    t6 = t6 * t6;
    t6 = t6 * 3.14159274;
    t18 = t18 + t18;
    t0.x = t0.x / t18;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x * 2.0 + -1.0;
    t18 = abs(t0.x) * -0.0187292993 + 0.0742610022;
    t18 = t18 * abs(t0.x) + -0.212114394;
    t18 = t18 * abs(t0.x) + 1.57072878;
    t2.x = -abs(t0.x) + 1.0;
    tb0 = t0.x<(-t0.x);
    t2.x = sqrt(t2.x);
    t8 = t18 * t2.x;
    t8 = t8 * -2.0 + 3.14159274;
    t0.x = tb0 ? t8 : float(0.0);
    t0.x = t18 * t2.x + t0.x;
    t0.x = (-t0.x) + 1.57079637;
    t0.x = t0.x * 0.318309873 + 0.5;
    t0.x = (-t0.x) * t2.z + t6;
    t0.x = t0.x / t6;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.x = t0.x + -1.0;
    t0.x = t12 * t0.x + 1.0;
    t2.x = (-vs_TEXCOORD0.x) + _ShadowBodies[0].w;
    t2.y = (-vs_TEXCOORD0.y) + _ShadowBodies[1].w;
    t2.z = (-vs_TEXCOORD0.z) + _ShadowBodies[2].w;
    t6 = dot(t2.xyz, t1.xyz);
    t12 = dot(t2.xyz, t2.xyz);
    t12 = (-t6) * t6 + t12;
    t12 = sqrt(t12);
    t18 = t6 / t19;
    tb6 = t6>=_ShadowBodies[3].w;
    t6 = tb6 ? 1.0 : float(0.0);
    t6 = t3.w * t6;
    t1.x = _SunRadius * t18 + _ShadowBodies[3].w;
    t18 = t18 * _SunRadius;
    t12 = (-t12) + t1.x;
    t1.x = min(t18, _ShadowBodies[3].w);
    t18 = t18 * t18;
    t18 = t18 * 3.14159274;
    t1.x = t1.x + t1.x;
    t12 = t12 / t1.x;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 * 2.0 + -1.0;
    t1.x = abs(t12) * -0.0187292993 + 0.0742610022;
    t1.x = t1.x * abs(t12) + -0.212114394;
    t1.x = t1.x * abs(t12) + 1.57072878;
    t7 = -abs(t12) + 1.0;
    tb12 = t12<(-t12);
    t7 = sqrt(t7);
    t13 = t7 * t1.x;
    t13 = t13 * -2.0 + 3.14159274;
    t12 = tb12 ? t13 : float(0.0);
    t12 = t1.x * t7 + t12;
    t12 = (-t12) + 1.57079637;
    t12 = t12 * 0.318309873 + 0.5;
    t12 = (-t12) * t2.w + t18;
    t12 = t12 / t18;
    t12 = clamp(t12, 0.0, 1.0);
    t12 = t12 + -1.0;
    t6 = t6 * t12 + 1.0;
    t16_11 = min(t6, t0.x);
    t16_0.w = min(t16_11, t16_5);
    t16_0.xyz = vec3(1.0, 1.0, 1.0);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "MAP_TYPE_CUBE6_1" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE2_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
  tmpvar_1 = color_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 163 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
Matrix 0 [_ShadowBodies]
Vector 5 [_SunPos]
Float 4 [_SunRadius]
"ps_3_0
def c6, 3.14159274, 2, -1, 1
def c7, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c8, 1.57079637, 0.318309873, 0.5, 0
def c9, -2, 3.14159274, 0, 1
dcl_texcoord v0.xyz
add r0.xyz, c0, -v0
dp3 r0.w, r0, r0
add r1.xyz, c5, -v0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c0.w
mov r2.x, c4.x
mad r0.w, r2.x, r0.z, c0.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.y, r0.z, c0.w
mul r0.z, r0.z, r0.z
add r0.w, r2.y, r2.y
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.y, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
mad r2.y, r0.w, c9.x, c9.y
mad r0.y, r2.y, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c0.w, c0.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c1.xxyz, -v0.xxyz
dp3 r2.y, r0.yzww, r0.yzww
dp3 r0.y, r0.yzww, r1
mad r0.z, r0.y, -r0.y, r2.y
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.w, r1.w, r0.y
add r0.y, r0.y, -c1.w
mad r2.y, r2.x, r0.w, c1.w
mul r0.w, r0.w, c4.x
add r0.z, -r0.z, r2.y
min r2.y, r0.w, c1.w
mul r0.w, r0.w, r0.w
mul r0.w, r0.w, c6.x
add r2.y, r2.y, r2.y
rcp r2.y, r2.y
mul_sat r0.z, r0.z, r2.y
mad r0.z, r0.z, c6.y, c6.z
mad r2.y, r0_abs.z, c7.x, c7.y
mad r2.y, r2.y, r0_abs.z, c7.z
mad r2.y, r2.y, r0_abs.z, c7.w
add r2.z, -r0_abs.z, c6.w
cmp r0.yz, r0, c9.xwzw, c9.xzww
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r2.y, r2.z, r2.y
mad r2.z, r2.y, c9.x, c9.y
mad r0.z, r2.z, r0.z, r2.y
add r0.z, -r0.z, c8.x
mad r0.z, r0.z, c8.y, c8.z
mul r2.y, c1.w, c1.w
mul r2.y, r2.y, c6.x
mad r0.z, r0.z, -r2.y, r0.w
mov_sat r2.y, r2.y
mul r0.y, r0.y, r2.y
rcp r0.w, r0.w
mul_sat r0.z, r0.w, r0.z
add r0.z, r0.z, c6.z
mad_pp r0.y, r0.y, r0.z, c6.w
min_pp r2.y, r0.y, r0.x
add r0.xyz, c2, -v0
dp3 r0.w, r0, r0
dp3 r0.x, r0, r1
mad r0.y, r0.x, -r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r0.x
add r0.x, r0.x, -c2.w
mad r0.w, r2.x, r0.z, c2.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r0.w
min r2.z, r0.z, c2.w
mul r0.z, r0.z, r0.z
add r0.w, r2.z, r2.z
rcp r0.w, r0.w
mul_sat r0.y, r0.w, r0.y
mad r0.y, r0.y, c6.y, c6.z
mad r0.w, r0_abs.y, c7.x, c7.y
mad r0.w, r0.w, r0_abs.y, c7.z
mad r0.w, r0.w, r0_abs.y, c7.w
add r2.z, -r0_abs.y, c6.w
cmp r0.xy, r0, c9.wzzw, c9.zwzw
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.w, r0.w, r2.z
mad r2.z, r0.w, c9.x, c9.y
mad r0.y, r2.z, r0.y, r0.w
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r0.w, c2.w, c2.w
mul r0.zw, r0, c6.x
mad r0.y, r0.y, -r0.w, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r0.w, r0.w
mul r0.x, r0.w, r0.x
mad_pp r0.x, r0.x, r0.y, c6.w
add r0.yzw, c3.xxyz, -v0.xxyz
dp3 r1.x, r0.yzww, r1
dp3 r0.y, r0.yzww, r0.yzww
mad r0.y, r1.x, -r1.x, r0.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.z, r1.w, r1.x
add r0.w, r1.x, -c3.w
mad r1.x, r2.x, r0.z, c3.w
mul r0.z, r0.z, c4.x
add r0.y, -r0.y, r1.x
min r1.x, r0.z, c3.w
mul r0.z, r0.z, r0.z
mul r0.z, r0.z, c6.x
add r1.x, r1.x, r1.x
rcp r1.x, r1.x
mul_sat r0.y, r0.y, r1.x
mad r0.y, r0.y, c6.y, c6.z
mad r1.x, r0_abs.y, c7.x, c7.y
mad r1.x, r1.x, r0_abs.y, c7.z
mad r1.x, r1.x, r0_abs.y, c7.w
add r1.y, -r0_abs.y, c6.w
cmp r0.yw, r0, c9.xzzw, c9.xwzz
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.x, r1.y, r1.x
mad r1.y, r1.x, c9.x, c9.y
mad r0.y, r1.y, r0.y, r1.x
add r0.y, -r0.y, c8.x
mad r0.y, r0.y, c8.y, c8.z
mul r1.x, c3.w, c3.w
mul r1.x, r1.x, c6.x
mad r0.y, r0.y, -r1.x, r0.z
rcp r0.z, r0.z
mul_sat r0.y, r0.z, r0.y
add r0.y, r0.y, c6.z
mov_sat r1.x, r1.x
mul r0.z, r0.w, r1.x
mad_pp r0.y, r0.z, r0.y, c6.w
min_pp r1.x, r0.y, r0.x
min_pp oC0.w, r1.x, r2.y
mov_pp oC0.xyz, c6.w

"
}
SubProgram "d3d11 " {
// Stats: 155 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
ConstBuffer "$Globals" 400
Matrix 272 [_ShadowBodies]
Float 336 [_SunRadius]
Vector 340 [_SunPos] 3
BindCB  "$Globals" 0
"ps_4_0
root12:aaabaaaa
eefiecedklpnbjabnppfljhcfoiaflhkkplghichabaaaaaaiibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibdaaaa
eaaaaaaapcaeaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaaaaaaaackbabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaa
bdaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
bfaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaalicaabaaaaaaaaaaa
akiacaaaaaaaaaaabfaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaabeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaacaaaaaabkaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaa
aaaaaadpdiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaaegiocaaa
aaaaaaaabeaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
nlapejeanlapejeanlapejeanlapejeadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaialpddaaaaakpcaabaaaadaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajbcaabaaa
aeaaaaaaakbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaaj
ccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaa
aaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
bdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaaaaaaaaa
bfaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaaibcaabaaa
acaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaabeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaibcaabaaaadaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaeaaaaaaakbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaabbaaaaaa
aaaaaaajccaabaaaaeaaaaaabkbabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaa
bcaaaaaaaaaaaaajecaabaaaaeaaaaaackbabaiaebaaaaaaabaaaaaackiacaaa
aaaaaaaabdaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaa
aaaaaaaabfaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabfaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaddaaaaai
bcaabaaaacaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaanlapejeaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakbcaabaaaacaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiccaabaaaacaaaaaackaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaaaocaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaialp
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajbcaabaaaacaaaaaaakbabaiaebaaaaaaabaaaaaadkiacaaa
aaaaaaaabbaaaaaaaaaaaaajccaabaaaacaaaaaabkbabaiaebaaaaaaabaaaaaa
dkiacaaaaaaaaaaabcaaaaaaaaaaaaajecaabaaaacaaaaaackbabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaabdaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaaaaaaaaabfaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
bfaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
abaaaaaaddaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdcaaaaakccaabaaa
abaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaadkaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
nlapmjdpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GL3x"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 205 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "MAP_TYPE_CUBE6_1" }
ConstBuffer "$Globals" 96
Matrix 0 [_ShadowBodies]
Float 64 [_SunRadius]
Vector 80 [_SunPos] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4x4 _ShadowBodies;
  float _SunRadius;
  float3 _SunPos;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  color_2.xyz = half3(float3(1.0, 1.0, 1.0));
  float4 v_3;
  v_3.x = _mtl_u._ShadowBodies[0].x;
  v_3.y = _mtl_u._ShadowBodies[1].x;
  v_3.z = _mtl_u._ShadowBodies[2].x;
  float tmpvar_4;
  tmpvar_4 = _mtl_u._ShadowBodies[3].x;
  v_3.w = tmpvar_4;
  half tmpvar_5;
  float3 tmpvar_6;
  tmpvar_6 = (_mtl_u._SunPos - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_7;
  tmpvar_7 = (3.141593 * (tmpvar_4 * tmpvar_4));
  float3 tmpvar_8;
  tmpvar_8 = (v_3.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, normalize(tmpvar_6));
  float tmpvar_10;
  tmpvar_10 = (_mtl_u._SunRadius * (tmpvar_9 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_11;
  tmpvar_11 = (3.141593 * (tmpvar_10 * tmpvar_10));
  float x_12;
  x_12 = ((2.0 * clamp (
    (((tmpvar_4 + tmpvar_10) - sqrt((
      dot (tmpvar_8, tmpvar_8)
     - 
      (tmpvar_9 * tmpvar_9)
    ))) / (2.0 * min (tmpvar_4, tmpvar_10)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_13;
  tmpvar_13 = mix (1.0, clamp ((
    (tmpvar_11 - (((0.3183099 * 
      (sign(x_12) * (1.570796 - (sqrt(
        (1.0 - abs(x_12))
      ) * (1.570796 + 
        (abs(x_12) * (-0.2146018 + (abs(x_12) * (0.08656672 + 
          (abs(x_12) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_7))
   / tmpvar_11), 0.0, 1.0), (float(
    (tmpvar_9 >= tmpvar_4)
  ) * clamp (tmpvar_7, 0.0, 1.0)));
  tmpvar_5 = half(tmpvar_13);
  float4 v_14;
  v_14.x = _mtl_u._ShadowBodies[0].y;
  v_14.y = _mtl_u._ShadowBodies[1].y;
  v_14.z = _mtl_u._ShadowBodies[2].y;
  float tmpvar_15;
  tmpvar_15 = _mtl_u._ShadowBodies[3].y;
  v_14.w = tmpvar_15;
  half tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = (3.141593 * (tmpvar_15 * tmpvar_15));
  float3 tmpvar_18;
  tmpvar_18 = (v_14.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, normalize(tmpvar_6));
  float tmpvar_20;
  tmpvar_20 = (_mtl_u._SunRadius * (tmpvar_19 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_21;
  tmpvar_21 = (3.141593 * (tmpvar_20 * tmpvar_20));
  float x_22;
  x_22 = ((2.0 * clamp (
    (((tmpvar_15 + tmpvar_20) - sqrt((
      dot (tmpvar_18, tmpvar_18)
     - 
      (tmpvar_19 * tmpvar_19)
    ))) / (2.0 * min (tmpvar_15, tmpvar_20)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_23;
  tmpvar_23 = mix (1.0, clamp ((
    (tmpvar_21 - (((0.3183099 * 
      (sign(x_22) * (1.570796 - (sqrt(
        (1.0 - abs(x_22))
      ) * (1.570796 + 
        (abs(x_22) * (-0.2146018 + (abs(x_22) * (0.08656672 + 
          (abs(x_22) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_17))
   / tmpvar_21), 0.0, 1.0), (float(
    (tmpvar_19 >= tmpvar_15)
  ) * clamp (tmpvar_17, 0.0, 1.0)));
  tmpvar_16 = half(tmpvar_23);
  float4 v_24;
  v_24.x = _mtl_u._ShadowBodies[0].z;
  v_24.y = _mtl_u._ShadowBodies[1].z;
  v_24.z = _mtl_u._ShadowBodies[2].z;
  float tmpvar_25;
  tmpvar_25 = _mtl_u._ShadowBodies[3].z;
  v_24.w = tmpvar_25;
  half tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (3.141593 * (tmpvar_25 * tmpvar_25));
  float3 tmpvar_28;
  tmpvar_28 = (v_24.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_29;
  tmpvar_29 = dot (tmpvar_28, normalize(tmpvar_6));
  float tmpvar_30;
  tmpvar_30 = (_mtl_u._SunRadius * (tmpvar_29 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_31;
  tmpvar_31 = (3.141593 * (tmpvar_30 * tmpvar_30));
  float x_32;
  x_32 = ((2.0 * clamp (
    (((tmpvar_25 + tmpvar_30) - sqrt((
      dot (tmpvar_28, tmpvar_28)
     - 
      (tmpvar_29 * tmpvar_29)
    ))) / (2.0 * min (tmpvar_25, tmpvar_30)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_33;
  tmpvar_33 = mix (1.0, clamp ((
    (tmpvar_31 - (((0.3183099 * 
      (sign(x_32) * (1.570796 - (sqrt(
        (1.0 - abs(x_32))
      ) * (1.570796 + 
        (abs(x_32) * (-0.2146018 + (abs(x_32) * (0.08656672 + 
          (abs(x_32) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_27))
   / tmpvar_31), 0.0, 1.0), (float(
    (tmpvar_29 >= tmpvar_25)
  ) * clamp (tmpvar_27, 0.0, 1.0)));
  tmpvar_26 = half(tmpvar_33);
  float4 v_34;
  v_34.x = _mtl_u._ShadowBodies[0].w;
  v_34.y = _mtl_u._ShadowBodies[1].w;
  v_34.z = _mtl_u._ShadowBodies[2].w;
  float tmpvar_35;
  tmpvar_35 = _mtl_u._ShadowBodies[3].w;
  v_34.w = tmpvar_35;
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = (3.141593 * (tmpvar_35 * tmpvar_35));
  float3 tmpvar_38;
  tmpvar_38 = (v_34.xyz - _mtl_i.xlv_TEXCOORD0);
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_38, normalize(tmpvar_6));
  float tmpvar_40;
  tmpvar_40 = (_mtl_u._SunRadius * (tmpvar_39 / sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  float tmpvar_41;
  tmpvar_41 = (3.141593 * (tmpvar_40 * tmpvar_40));
  float x_42;
  x_42 = ((2.0 * clamp (
    (((tmpvar_35 + tmpvar_40) - sqrt((
      dot (tmpvar_38, tmpvar_38)
     - 
      (tmpvar_39 * tmpvar_39)
    ))) / (2.0 * min (tmpvar_35, tmpvar_40)))
  , 0.0, 1.0)) - 1.0);
  float tmpvar_43;
  tmpvar_43 = mix (1.0, clamp ((
    (tmpvar_41 - (((0.3183099 * 
      (sign(x_42) * (1.570796 - (sqrt(
        (1.0 - abs(x_42))
      ) * (1.570796 + 
        (abs(x_42) * (-0.2146018 + (abs(x_42) * (0.08656672 + 
          (abs(x_42) * -0.03102955)
        ))))
      ))))
    ) + 0.5) * tmpvar_37))
   / tmpvar_41), 0.0, 1.0), (float(
    (tmpvar_39 >= tmpvar_35)
  ) * clamp (tmpvar_37, 0.0, 1.0)));
  tmpvar_36 = half(tmpvar_43);
  color_2.w = min (min (tmpvar_5, tmpvar_16), min (tmpvar_26, tmpvar_36));
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