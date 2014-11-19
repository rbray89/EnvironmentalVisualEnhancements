Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,1)) = 1
		_RimDistSub ("Rim Distance Sub", Range(0,2)) = 1.01
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Ocean Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	}

Category {
	
	Tags { "Queue"="Overlay" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Off}
	ZTest Off
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 29 to 29
//   d3d11 - ALU: 27 to 27, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_1.xyw = o_6.xyw;
  vec3 p_9;
  p_9 = (_PlanetOrigin - _WorldSpaceCameraPos);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - _OceanRadius);
  xlv_TEXCOORD6 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float avgHeight_1;
  float oceanSphereDist_2;
  float sphereDist_3;
  float depth_4;
  vec4 color_5;
  color_5 = _Color;
  float tmpvar_6;
  tmpvar_6 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_4 = tmpvar_6;
  sphereDist_3 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD6, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD6, xlv_TEXCOORD6) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6));
  oceanSphereDist_2 = tmpvar_6;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_2 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_2, tmpvar_6);
  depth_4 = tmpvar_12;
  avgHeight_1 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_3 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_4 = tmpvar_14;
    vec3 p_15;
    p_15 = ((_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7)) - _PlanetOrigin);
    avgHeight_1 = ((sqrt(dot (p_15, p_15)) + tmpvar_11) * 0.5);
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_16;
      float tmpvar_17;
      tmpvar_17 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_18;
      tmpvar_18 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_19;
      tmpvar_19 = mix ((tmpvar_8 - tmpvar_17), (tmpvar_17 + tmpvar_8), tmpvar_18);
      sphereDist_3 = tmpvar_19;
      float tmpvar_20;
      tmpvar_20 = min ((tmpvar_8 + tmpvar_17), depth_4);
      oldDepth_16 = depth_4;
      depth_4 = mix ((tmpvar_20 - tmpvar_19), min (depth_4, tmpvar_19), tmpvar_18);
      vec3 p_21;
      p_21 = ((_WorldSpaceCameraPos + (tmpvar_20 * tmpvar_7)) - _PlanetOrigin);
      avgHeight_1 = ((sqrt(dot (p_21, p_21)) + mix (mix (_SphereRadius, tmpvar_9, (tmpvar_20 - oldDepth_16)), tmpvar_11, tmpvar_18)) * 0.5);
    };
  };
  float tmpvar_22;
  tmpvar_22 = (mix (0.0, depth_4, clamp (sphereDist_3, 0.0, 1.0)) * (_Visibility * clamp ((1.0 - ((avgHeight_1 - _OceanRadius) / (_SphereRadius - _OceanRadius))), 0.0, 1.0)));
  depth_4 = tmpvar_22;
  color_5.w = (_Color.w * tmpvar_22);
  gl_FragData[0] = color_5;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
mul r0.y, r0, c13.x
dp4 r1.z, v0, c6
mov o0, r1
mad o1.xy, r0.z, c14.zwzw, r0
mov r0.xyz, c12
add r0.xyz, -c16, r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
add o5.x, r0, -c15
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r2.xyz, -r1, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mov o2.xyz, r1
mov r1.xyz, c16
mul o3.xyz, r1.w, r2
rcp o4.x, r1.w
add o6.xyz, -c12, r1
mov o1.z, -r0.x
mov o1.w, r0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 112 // 112 used size, 14 vars
Float 92 [_OceanRadius]
Vector 100 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 32 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednmeakpoancfonagdicifffeaoonjbdocabaaaaaaaiagaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaiahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchmaeaaaaeaaaabaabpabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaa
acaaaaaagfaaaaadiccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
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
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
iccabaaaacaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
aeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
jgihcaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajiccabaaaadaaaaaaakaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
afaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (_PlanetOrigin - _WorldSpaceCameraPos);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - _OceanRadius);
  xlv_TEXCOORD6 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float avgHeight_2;
  highp float oceanSphereDist_3;
  mediump vec3 worldDir_4;
  highp float sphereDist_5;
  highp float depth_6;
  mediump vec4 color_7;
  color_7 = _Color;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_6 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (1.0/(((_ZBufferParams.z * depth_6) + _ZBufferParams.w)));
  depth_6 = tmpvar_9;
  sphereDist_5 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_4 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD6, worldDir_4);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD6, xlv_TEXCOORD6) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6));
  oceanSphereDist_3 = tmpvar_9;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_3, tmpvar_9);
  depth_6 = tmpvar_15;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_5 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_6 = tmpvar_17;
    highp vec3 p_18;
    p_18 = ((_WorldSpaceCameraPos + (tmpvar_17 * worldDir_4)) - _PlanetOrigin);
    avgHeight_2 = ((sqrt(dot (p_18, p_18)) + tmpvar_14) * 0.5);
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_19;
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_22;
      tmpvar_22 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = mix ((tmpvar_11 - tmpvar_21), (tmpvar_21 + tmpvar_11), sphereCheck_20);
      sphereDist_5 = tmpvar_23;
      highp float tmpvar_24;
      tmpvar_24 = min ((tmpvar_11 + tmpvar_21), depth_6);
      oldDepth_19 = depth_6;
      depth_6 = mix ((tmpvar_24 - tmpvar_23), min (depth_6, tmpvar_23), sphereCheck_20);
      highp vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_24 * worldDir_4)) - _PlanetOrigin);
      avgHeight_2 = ((sqrt(dot (p_25, p_25)) + mix (mix (_SphereRadius, tmpvar_12, (tmpvar_24 - oldDepth_19)), tmpvar_14, sphereCheck_20)) * 0.5);
    };
  };
  highp float tmpvar_26;
  tmpvar_26 = (mix (0.0, depth_6, clamp (sphereDist_5, 0.0, 1.0)) * (_Visibility * clamp ((1.0 - ((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius))), 0.0, 1.0)));
  depth_6 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (color_7.w * tmpvar_26);
  color_7.w = tmpvar_27;
  tmpvar_1 = color_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (_PlanetOrigin - _WorldSpaceCameraPos);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - _OceanRadius);
  xlv_TEXCOORD6 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float avgHeight_2;
  highp float oceanSphereDist_3;
  mediump vec3 worldDir_4;
  highp float sphereDist_5;
  highp float depth_6;
  mediump vec4 color_7;
  color_7 = _Color;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_6 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (1.0/(((_ZBufferParams.z * depth_6) + _ZBufferParams.w)));
  depth_6 = tmpvar_9;
  sphereDist_5 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_4 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD6, worldDir_4);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD6, xlv_TEXCOORD6) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6));
  oceanSphereDist_3 = tmpvar_9;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_3, tmpvar_9);
  depth_6 = tmpvar_15;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_5 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_6 = tmpvar_17;
    highp vec3 p_18;
    p_18 = ((_WorldSpaceCameraPos + (tmpvar_17 * worldDir_4)) - _PlanetOrigin);
    avgHeight_2 = ((sqrt(dot (p_18, p_18)) + tmpvar_14) * 0.5);
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_19;
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_22;
      tmpvar_22 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = mix ((tmpvar_11 - tmpvar_21), (tmpvar_21 + tmpvar_11), sphereCheck_20);
      sphereDist_5 = tmpvar_23;
      highp float tmpvar_24;
      tmpvar_24 = min ((tmpvar_11 + tmpvar_21), depth_6);
      oldDepth_19 = depth_6;
      depth_6 = mix ((tmpvar_24 - tmpvar_23), min (depth_6, tmpvar_23), sphereCheck_20);
      highp vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_24 * worldDir_4)) - _PlanetOrigin);
      avgHeight_2 = ((sqrt(dot (p_25, p_25)) + mix (mix (_SphereRadius, tmpvar_12, (tmpvar_24 - oldDepth_19)), tmpvar_14, sphereCheck_20)) * 0.5);
    };
  };
  highp float tmpvar_26;
  tmpvar_26 = (mix (0.0, depth_6, clamp (sphereDist_5, 0.0, 1.0)) * (_Visibility * clamp ((1.0 - ((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius))), 0.0, 1.0)));
  depth_6 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (color_7.w * tmpvar_26);
  color_7.w = tmpvar_27;
  tmpvar_1 = color_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

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
#line 410
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform sampler2D _CameraDepthTexture;
#line 393
uniform highp float _Visibility;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _FadeDist;
#line 397
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
uniform highp float _OceanRadius;
#line 401
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 422
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 422
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 426
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 430
    o.scrPos = ComputeScreenPos( o.pos);
    o.altitude = (distance( _PlanetOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (_PlanetOrigin - _WorldSpaceCameraPos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    #line 434
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out highp float xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = float(xl_retval.viewDist);
    xlv_TEXCOORD5 = float(xl_retval.altitude);
    xlv_TEXCOORD6 = vec3(xl_retval.L);
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
#line 410
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform sampler2D _CameraDepthTexture;
#line 393
uniform highp float _Visibility;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _FadeDist;
#line 397
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
uniform highp float _OceanRadius;
#line 401
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 422
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
lowp vec4 frag( in v2f IN ) {
    #line 438
    mediump vec4 color = _Color;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    highp float avgHeight = _SphereRadius;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 458
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        avgHeight = distance( (_WorldSpaceCameraPos + (depth * worldDir)), _PlanetOrigin);
        #line 462
        avgHeight += Llength;
        avgHeight *= 0.5;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 467
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 471
            highp float oldDepth = depth;
            depth = mix( (minFar - sphereDist), min( depth, sphereDist), sphereCheck);
            avgHeight = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), _PlanetOrigin);
            avgHeight += mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            #line 475
            avgHeight *= 0.5;
        }
    }
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    depth *= (_Visibility * xll_saturate_f((1.0 - ((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    #line 479
    color.w *= depth;
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in highp float xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDist = float(xlv_TEXCOORD4);
    xlt_IN.altitude = float(xlv_TEXCOORD5);
    xlt_IN.L = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 87 to 87, TEX: 1 to 1, FLOW: 2 to 2
//   d3d11 - ALU: 66 to 66, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_SphereRadius]
Vector 6 [_PlanetOrigin]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 87 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c7, 1.00000000, 0.00000000, 0.50000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord6 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.z, v2, r0
dp3 r0.w, v2, v2
mad r1.x, -r1.z, r1.z, r0.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.w, r1.x, r1.x
mad r1.y, c4.x, c4.x, -r1.w
rsq r1.y, r1.y
rcp r2.y, r1.y
add r1.y, -r1.x, c4.x
rsq r0.w, r0.w
cmp r2.x, r1.z, c7, c7.y
cmp r1.y, r1, c7.x, c7
mul_pp r1.y, r1, r2.x
texldp r2.x, v0, s0
mad r2.x, r2, c1.z, c1.w
add r2.y, r1.z, -r2
rcp r2.x, r2.x
cmp r1.y, -r1, r2.x, r2
rcp r0.w, r0.w
add r2.y, r0.w, -c5.x
cmp r2.z, r1, c7.y, c7.x
cmp r2.y, r2, c7, c7.x
mul_pp r2.y, r2, r2.z
min r1.y, r1, r2.x
if_gt r2.y, c7.y
mad r1.z, r0.w, r0.w, -r1.w
mad r1.x, c5, c5, -r1.w
rsq r1.z, r1.z
rsq r1.x, r1.x
rcp r1.z, r1.z
rcp r1.x, r1.x
add r1.x, r1, -r1.z
min r1.y, r1.x, r1
mad r0.xyz, r1.y, r0, c0
add r0.xyz, -r0, c6
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.x, r0.w, r0
mul r0.x, r0, c7.z
else
mad r1.w, c5.x, c5.x, -r1
rsq r1.w, r1.w
rcp r1.w, r1.w
add r2.x, r1.z, r1.w
min r2.y, r2.x, r1
mad r0.xyz, r2.y, r0, c0
add r0.xyz, -r0, c6
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.y, r0.x
add r0.z, r1.x, -c5.x
add r0.x, -r1.y, r2.y
mad r2.z, r0.x, r0, c5.x
add r0.z, r1, -r1.w
add_sat r0.x, -r0.w, c5
add r1.w, r0, -r2.z
mad r1.w, r0.x, r1, r2.z
add r0.y, r0, r1.w
add r0.w, r2.x, -r0.z
mad r1.w, r0.x, r0, r0.z
add r0.z, -r1.x, c5.x
cmp r0.w, r1.z, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r1.x, -r0.z, c7.y, r1.w
cmp r1.z, -r0, c5.x, r0.y
add r0.w, -r1.x, r2.y
min r0.y, r1.x, r1
add r0.y, r0, -r0.w
mad r0.y, r0.x, r0, r0.w
mul r1.w, r1.z, c7.z
cmp r0.x, -r0.z, r1.z, r1.w
cmp r1.y, -r0.z, r1, r0
endif
mov r0.y, c5.x
add r0.y, -c4.x, r0
add r0.x, r0, -c4
rcp r0.y, r0.y
mad_sat r0.y, -r0.x, r0, c7.x
mov_sat r0.x, r1
mul r0.y, r0, c3.x
mul r0.x, r0, r1.y
mul r0.x, r0, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 112 // 112 used size, 14 vars
Vector 48 [_Color] 4
Float 64 [_Visibility]
Float 92 [_OceanRadius]
Float 96 [_SphereRadius]
Vector 100 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 75 instructions, 6 temp regs, 0 temp arrays:
// ALU 63 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbpmgjemifjjnmjabfhgdnfedbakgomiaabaaaaaalmakaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaaaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaaiaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgmajaaaaeaaaaaaaflacaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaambcaabaaaacaaaaaadkiacaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaa
afaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaamicaabaaaabaaaaaaakiacaaa
aaaaaaaaagaaaaaaakiacaaaaaaaaaaaagaaaaaadkaabaiaebaaaaaaabaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaaaabaaaaaaakaabaia
ebaaaaaaacaaaaaabnaaaaahccaabaaaacaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaabnaaaaaiecaabaaaacaaaaaadkiacaaaaaaaaaaaafaaaaaackaabaaa
abaaaaaaabaaaaahecaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaa
dhaaaaajbcaabaaaacaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaaddaaaaahbcaabaaaadaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
aaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaddaaaaah
bcaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
aeaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaajhcaabaaaaeaaaaaaegacbaaaaeaaaaaajgihcaiaebaaaaaaaaaaaaaa
agaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaacaaaaaa
akaabaiaebaaaaaaadaaaaaaakaabaaaacaaaaaaaaaaaaajicaabaaaadaaaaaa
ckaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadcaaaaakicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaaakiacaaaaaaaaaaaagaaaaaa
elaaaaaficaabaaaadaaaaaabkaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaa
ckaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaabnaaaaai
ecaabaaaabaaaaaaakiacaaaaaaaaaaaagaaaaaackaabaaaabaaaaaaabaaaaah
ecaabaaaabaaaaaabkaabaaaacaaaaaackaabaaaabaaaaaaelaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaaaaaaaaiccaabaaaaeaaaaaabkaabaiaebaaaaaa
abaaaaaadkaabaaaabaaaaaaaaaaaaaiccaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaa
dkaabaaaadaaaaaaaacaaaajccaabaaaacaaaaaadkaabaiaebaaaaaaadaaaaaa
akiacaaaaaaaaaaaagaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaacaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaacaaaaaadiaaaaahecaabaaaafaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaadpdgaaaaafccaabaaaadaaaaaaabeaaaaaaaaaaaaadgaaaaag
ecaabaaaadaaaaaaakiacaaaaaaaaaaaagaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaafaaaaaa
bkaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaaakaabaaaadaaaaaabkaabaaaafaaaaaaaaaaaaaiccaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaafaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajbcaabaaaafaaaaaa
bkaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadhaaaaajocaabaaa
abaaaaaakgakbaaaabaaaaaaagajbaaaafaaaaaaagajbaaaadaaaaaaddaaaaah
bcaabaaaaeaaaaaaakaabaaaadaaaaaabkaabaaaaeaaaaaadcaaaaakhcaabaaa
aaaaaaaaagaabaaaaeaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgihcaiaebaaaaaaaaaaaaaa
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
dkaabaaaadaaaaaaakaabaaaaaaaaaaadbaaaaaiccaabaaaaaaaaaaadkaabaaa
adaaaaaaakiacaaaaaaaaaaaagaaaaaaabaaaaahccaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaaaeaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdhaaaaajhcaabaaaaaaaaaaafgafbaaaaaaaaaaabgagbaaa
aeaaaaaaggalbaaaabaaaaaadgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
ccaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaafaaaaaa
aaaaaaakecaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaagaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaaacaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 151

	
		}
		
	} 
	
}
}
