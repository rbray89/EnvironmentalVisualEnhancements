Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	}

Category {
	
	Tags { "Queue"="Transparent-5" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Off}
	ZTest Off
	ColorMask RGB
	Cull Front Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 2
//   d3d9 - ALU: 23 to 30
//   d3d11 - ALU: 19 to 27, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD5 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD6 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float avgHeight_1;
  float oceanSphereDist_2;
  float sphereDist_3;
  float depth_4;
  vec4 color_5;
  color_5 = _Color;
  depth_4 = 1e+32;
  sphereDist_3 = 0.0;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD6, tmpvar_6);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD6, xlv_TEXCOORD6) - (tmpvar_7 * tmpvar_7)));
  float tmpvar_9;
  tmpvar_9 = pow (tmpvar_8, 2.0);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6));
  oceanSphereDist_2 = 1e+32;
  if (((tmpvar_8 <= _OceanRadius) && (tmpvar_7 >= 0.0))) {
    oceanSphereDist_2 = (tmpvar_7 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_9)));
  };
  float tmpvar_11;
  tmpvar_11 = min (oceanSphereDist_2, 1e+32);
  depth_4 = tmpvar_11;
  avgHeight_1 = _SphereRadius;
  if (((tmpvar_10 < _SphereRadius) && (tmpvar_7 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_9)) - sqrt((pow (tmpvar_10, 2.0) - tmpvar_9)));
    sphereDist_3 = tmpvar_12;
    float tmpvar_13;
    tmpvar_13 = min (tmpvar_11, tmpvar_12);
    depth_4 = tmpvar_13;
    float tmpvar_14;
    vec3 p_15;
    p_15 = ((_WorldSpaceCameraPos + (tmpvar_13 * tmpvar_6)) - xlv_TEXCOORD2);
    tmpvar_14 = sqrt(dot (p_15, p_15));
    avgHeight_1 = ((0.75 * min (tmpvar_14, tmpvar_10)) + (0.25 * max (tmpvar_14, tmpvar_10)));
  } else {
    if (((tmpvar_8 <= _SphereRadius) && (tmpvar_7 >= 0.0))) {
      float oldDepth_16;
      float tmpvar_17;
      tmpvar_17 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_9));
      float tmpvar_18;
      tmpvar_18 = clamp ((_SphereRadius - tmpvar_10), 0.0, 1.0);
      float tmpvar_19;
      tmpvar_19 = mix ((tmpvar_7 - tmpvar_17), (tmpvar_17 + tmpvar_7), tmpvar_18);
      sphereDist_3 = tmpvar_19;
      float tmpvar_20;
      tmpvar_20 = min ((tmpvar_7 + tmpvar_17), depth_4);
      oldDepth_16 = depth_4;
      depth_4 = mix ((tmpvar_20 - tmpvar_19), min (depth_4, tmpvar_19), tmpvar_18);
      float tmpvar_21;
      vec3 p_22;
      p_22 = ((_WorldSpaceCameraPos + (tmpvar_20 * tmpvar_6)) - xlv_TEXCOORD2);
      tmpvar_21 = sqrt(dot (p_22, p_22));
      float tmpvar_23;
      tmpvar_23 = mix (mix (_SphereRadius, tmpvar_8, (tmpvar_20 - oldDepth_16)), tmpvar_10, tmpvar_18);
      avgHeight_1 = ((0.75 * min (tmpvar_21, tmpvar_23)) + (0.25 * max (tmpvar_21, tmpvar_23)));
    };
  };
  float tmpvar_24;
  tmpvar_24 = (mix (0.0, depth_4, clamp (sphereDist_3, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_1 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_4 = tmpvar_24;
  color_5.w = (_Color.w * tmpvar_24);
  gl_FragData[0] = color_5;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Float 9 [_OceanRadius]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_position0 v0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o2.xyz, r0
rcp r0.x, r1.x
mul o3.xyz, r0.w, r2
rcp o4.x, r0.w
add o5.x, r0, -c9
mov o6.xyz, -r3
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 96 // 72 used size, 8 vars
Float 68 [_OceanRadius]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgejkpnecpbpeeifmfcmlmjhhombgbhhnabaaaaaaoeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaiahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcfiadaaaaeaaaabaangaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadiccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajiccabaaa
adaaaaaadkaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaeaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD5 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD6 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
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
  depth_6 = 1e+32;
  sphereDist_5 = 0.0;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD6, worldDir_4);
  highp float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD6, xlv_TEXCOORD6) - (tmpvar_9 * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  highp float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, 1e+32);
  depth_6 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    highp float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_5 = tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_6 = tmpvar_15;
    highp float tmpvar_16;
    highp vec3 p_17;
    p_17 = ((_WorldSpaceCameraPos + (tmpvar_15 * worldDir_4)) - xlv_TEXCOORD2);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_12)) + (0.25 * max (tmpvar_16, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      highp float oldDepth_18;
      mediump float sphereCheck_19;
      highp float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      highp float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      sphereCheck_19 = tmpvar_21;
      highp float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), sphereCheck_19);
      sphereDist_5 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_6);
      oldDepth_18 = depth_6;
      depth_6 = mix ((tmpvar_23 - tmpvar_22), min (depth_6, tmpvar_22), sphereCheck_19);
      highp float tmpvar_24;
      highp vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_23 * worldDir_4)) - xlv_TEXCOORD2);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      highp float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_18)), tmpvar_12, sphereCheck_19);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  highp float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_6, clamp (sphereDist_5, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_6 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (color_7.w * tmpvar_27);
  color_7.w = tmpvar_28;
  tmpvar_1 = color_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD5 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD6 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
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
  depth_6 = 1e+32;
  sphereDist_5 = 0.0;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD6, worldDir_4);
  highp float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD6, xlv_TEXCOORD6) - (tmpvar_9 * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  highp float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, 1e+32);
  depth_6 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    highp float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_5 = tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_6 = tmpvar_15;
    highp float tmpvar_16;
    highp vec3 p_17;
    p_17 = ((_WorldSpaceCameraPos + (tmpvar_15 * worldDir_4)) - xlv_TEXCOORD2);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_12)) + (0.25 * max (tmpvar_16, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      highp float oldDepth_18;
      mediump float sphereCheck_19;
      highp float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      highp float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      sphereCheck_19 = tmpvar_21;
      highp float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), sphereCheck_19);
      sphereDist_5 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_6);
      oldDepth_18 = depth_6;
      depth_6 = mix ((tmpvar_23 - tmpvar_22), min (depth_6, tmpvar_22), sphereCheck_19);
      highp float tmpvar_24;
      highp vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_23 * worldDir_4)) - xlv_TEXCOORD2);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      highp float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_18)), tmpvar_12, sphereCheck_19);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  highp float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_6, clamp (sphereDist_5, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_6 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (color_7.w * tmpvar_27);
  color_7.w = tmpvar_28;
  tmpvar_1 = color_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" }
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
#line 404
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
#line 397
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 416
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 424
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 428
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
#line 404
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
#line 397
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 416
#line 430
lowp vec4 frag( in v2f IN ) {
    #line 432
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 436
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 440
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 444
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 448
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        #line 452
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp float height1 = distance( (_WorldSpaceCameraPos + (depth * worldDir)), IN.worldOrigin);
        highp float height2 = Llength;
        #line 456
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 460
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 464
            highp float oldDepth = depth;
            depth = mix( (minFar - sphereDist), min( depth, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            #line 468
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    #line 472
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

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" }
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
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = _PlanetOrigin;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD5 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD6 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
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
    float tmpvar_15;
    vec3 p_16;
    p_16 = ((_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7)) - xlv_TEXCOORD2);
    tmpvar_15 = sqrt(dot (p_16, p_16));
    avgHeight_1 = ((0.75 * min (tmpvar_15, tmpvar_11)) + (0.25 * max (tmpvar_15, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_17;
      float tmpvar_18;
      tmpvar_18 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_19;
      tmpvar_19 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_20;
      tmpvar_20 = mix ((tmpvar_8 - tmpvar_18), (tmpvar_18 + tmpvar_8), tmpvar_19);
      sphereDist_3 = tmpvar_20;
      float tmpvar_21;
      tmpvar_21 = min ((tmpvar_8 + tmpvar_18), depth_4);
      oldDepth_17 = depth_4;
      depth_4 = mix ((tmpvar_21 - tmpvar_20), min (depth_4, tmpvar_20), tmpvar_19);
      float tmpvar_22;
      vec3 p_23;
      p_23 = ((_WorldSpaceCameraPos + (tmpvar_21 * tmpvar_7)) - xlv_TEXCOORD2);
      tmpvar_22 = sqrt(dot (p_23, p_23));
      float tmpvar_24;
      tmpvar_24 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_21 - oldDepth_17)), tmpvar_11, tmpvar_19);
      avgHeight_1 = ((0.75 * min (tmpvar_22, tmpvar_24)) + (0.25 * max (tmpvar_22, tmpvar_24)));
    };
  };
  float tmpvar_25;
  tmpvar_25 = (mix (0.0, depth_4, clamp (sphereDist_3, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_1 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_4 = tmpvar_25;
  color_5.w = (_Color.w * tmpvar_25);
  gl_FragData[0] = color_5;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" }
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
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
mul r0.y, r0, c13.x
mad o1.xy, r0.z, c14.zwzw, r0
dp4 r1.z, v0, c6
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
dp3 r1.x, r1, r1
mov o2.xyz, r0
rsq r0.x, r1.x
rcp r0.x, r0.x
add o6.x, r0, -c15
mov r0.xyz, c16
dp4 r1.x, v0, c2
mul o4.xyz, r1.w, r2
mov o3.xyz, c16
rcp o5.x, r1.w
add o7.xyz, -c12, r0
mov o1.z, -r1.x
mov o1.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 96 // 92 used size, 8 vars
Float 68 [_OceanRadius]
Vector 80 [_PlanetOrigin] 3
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
// 33 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpdebgleoncdgcbniddciikffdajihejcabaaaaaacmagaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaiahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefckaaeaaaaeaaaabaaciabaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajiccabaaaadaaaaaadkaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaa
aeaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaaaaaaaaaafaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" }
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
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = _PlanetOrigin;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD5 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD6 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
    highp float tmpvar_18;
    highp vec3 p_19;
    p_19 = ((_WorldSpaceCameraPos + (tmpvar_17 * worldDir_4)) - xlv_TEXCOORD2);
    tmpvar_18 = sqrt(dot (p_19, p_19));
    avgHeight_2 = ((0.75 * min (tmpvar_18, tmpvar_14)) + (0.25 * max (tmpvar_18, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_20;
      mediump float sphereCheck_21;
      highp float tmpvar_22;
      tmpvar_22 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_23;
      tmpvar_23 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_21 = tmpvar_23;
      highp float tmpvar_24;
      tmpvar_24 = mix ((tmpvar_11 - tmpvar_22), (tmpvar_22 + tmpvar_11), sphereCheck_21);
      sphereDist_5 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = min ((tmpvar_11 + tmpvar_22), depth_6);
      oldDepth_20 = depth_6;
      depth_6 = mix ((tmpvar_25 - tmpvar_24), min (depth_6, tmpvar_24), sphereCheck_21);
      highp float tmpvar_26;
      highp vec3 p_27;
      p_27 = ((_WorldSpaceCameraPos + (tmpvar_25 * worldDir_4)) - xlv_TEXCOORD2);
      tmpvar_26 = sqrt(dot (p_27, p_27));
      highp float tmpvar_28;
      tmpvar_28 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_25 - oldDepth_20)), tmpvar_14, sphereCheck_21);
      avgHeight_2 = ((0.75 * min (tmpvar_26, tmpvar_28)) + (0.25 * max (tmpvar_26, tmpvar_28)));
    };
  };
  highp float tmpvar_29;
  tmpvar_29 = (mix (0.0, depth_6, clamp (sphereDist_5, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_6 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (color_7.w * tmpvar_29);
  color_7.w = tmpvar_30;
  tmpvar_1 = color_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" }
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
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = _PlanetOrigin;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD5 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD6 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
    highp float tmpvar_18;
    highp vec3 p_19;
    p_19 = ((_WorldSpaceCameraPos + (tmpvar_17 * worldDir_4)) - xlv_TEXCOORD2);
    tmpvar_18 = sqrt(dot (p_19, p_19));
    avgHeight_2 = ((0.75 * min (tmpvar_18, tmpvar_14)) + (0.25 * max (tmpvar_18, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_20;
      mediump float sphereCheck_21;
      highp float tmpvar_22;
      tmpvar_22 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_23;
      tmpvar_23 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_21 = tmpvar_23;
      highp float tmpvar_24;
      tmpvar_24 = mix ((tmpvar_11 - tmpvar_22), (tmpvar_22 + tmpvar_11), sphereCheck_21);
      sphereDist_5 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = min ((tmpvar_11 + tmpvar_22), depth_6);
      oldDepth_20 = depth_6;
      depth_6 = mix ((tmpvar_25 - tmpvar_24), min (depth_6, tmpvar_24), sphereCheck_21);
      highp float tmpvar_26;
      highp vec3 p_27;
      p_27 = ((_WorldSpaceCameraPos + (tmpvar_25 * worldDir_4)) - xlv_TEXCOORD2);
      tmpvar_26 = sqrt(dot (p_27, p_27));
      highp float tmpvar_28;
      tmpvar_28 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_25 - oldDepth_20)), tmpvar_14, sphereCheck_21);
      avgHeight_2 = ((0.75 * min (tmpvar_26, tmpvar_28)) + (0.25 * max (tmpvar_26, tmpvar_28)));
    };
  };
  highp float tmpvar_29;
  tmpvar_29 = (mix (0.0, depth_6, clamp (sphereDist_5, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_6 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (color_7.w * tmpvar_29);
  color_7.w = tmpvar_30;
  tmpvar_1 = color_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" }
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
#line 404
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
#line 397
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 416
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
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 424
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 428
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 404
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
#line 397
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 416
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 431
lowp vec4 frag( in v2f IN ) {
    #line 433
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 437
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 441
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 446
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 450
    highp float avgHeight = _SphereRadius;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 454
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp float height1 = distance( (_WorldSpaceCameraPos + (depth * worldDir)), IN.worldOrigin);
        #line 458
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 463
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 467
            highp float oldDepth = depth;
            depth = mix( (minFar - sphereDist), min( depth, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            #line 471
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    #line 475
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
// Fragment combos: 2
//   d3d9 - ALU: 89 to 91, TEX: 1 to 1, FLOW: 2 to 2
//   d3d11 - ALU: 61 to 64, TEX: 0 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_SphereRadius]
"ps_3_0
; 89 ALU, 2 FLOW
def c5, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c6, 0.75000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1.xyz
dcl_texcoord6 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.z, r0, v2
dp3 r0.w, v2, v2
mad r1.x, -r1.z, r1.z, r0.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.w, r1.x, r1.x
mad r1.y, c3.x, c3.x, -r1.w
rsq r2.y, r1.y
add r1.y, -r1.x, c3.x
rsq r0.w, r0.w
cmp r2.x, r1.z, c5, c5.y
cmp r1.y, r1, c5.x, c5
mul_pp r1.y, r1, r2.x
rcp r2.x, r2.y
add r2.x, r1.z, -r2
cmp r1.y, -r1, c5.z, r2.x
rcp r0.w, r0.w
add r2.x, r0.w, -c4
cmp r2.y, r1.z, c5, c5.x
cmp r2.x, r2, c5.y, c5
mul_pp r2.x, r2, r2.y
min r1.y, r1, c5.z
if_gt r2.x, c5.y
mad r1.z, r0.w, r0.w, -r1.w
mad r1.x, c4, c4, -r1.w
rsq r1.z, r1.z
rsq r1.x, r1.x
rcp r1.z, r1.z
rcp r1.x, r1.x
add r1.x, r1, -r1.z
min r1.y, r1.x, r1
mad r0.xyz, r1.y, r0, c0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
max r0.y, r0.w, r0.x
mul r0.y, r0, c5.w
min r0.x, r0.w, r0
mad r0.x, r0, c6, r0.y
else
mad r1.w, c4.x, c4.x, -r1
rsq r1.w, r1.w
rcp r1.w, r1.w
add r2.x, r1.z, r1.w
min r2.y, r2.x, r1
add r1.w, r1.z, -r1
mad r0.xyz, r2.y, r0, c0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
add r2.x, r2, -r1.w
add r0.y, -r1, r2
add r0.z, r1.x, -c4.x
mad r0.z, r0.y, r0, c4.x
add_sat r0.y, -r0.w, c4.x
add r2.z, r0.w, -r0
add r0.w, -r1.x, c4.x
mad r1.w, r0.y, r2.x, r1
mad r0.z, r0.y, r2, r0
rcp r0.x, r0.x
max r2.x, r0, r0.z
cmp r1.x, r1.z, c5, c5.y
cmp r0.w, r0, c5.x, c5.y
mul_pp r0.w, r0, r1.x
cmp r1.x, -r0.w, c5.y, r1.w
add r1.z, -r1.x, r2.y
min r1.w, r1.x, r1.y
add r1.w, r1, -r1.z
mad r0.y, r0, r1.w, r1.z
mul r2.x, r2, c5.w
min r0.x, r0, r0.z
mad r0.x, r0, c6, r2
cmp r0.x, -r0.w, c4, r0
cmp r1.y, -r0.w, r1, r0
endif
mov r0.y, c4.x
add r0.y, -c3.x, r0
rcp r0.y, r0.y
add r0.x, r0, -c3
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c5.x
mov_sat r0.x, r1
mul r0.y, r0, c2.x
mul r0.x, r0, r1.y
mul r0.x, r0, r0.y
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" }
ConstBuffer "$Globals" 96 // 76 used size, 8 vars
Vector 48 [_Color] 4
Float 64 [_Visibility]
Float 68 [_OceanRadius]
Float 72 [_SphereRadius]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 69 instructions, 6 temp regs, 0 temp arrays:
// ALU 59 float, 0 int, 2 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedecohgpemebnknhhhlaldcmijdlefbdckabaaaaaanaajaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaaaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaaiaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefciaaiaaaaeaaaaaaacaacaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaa
aaaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egacbaaaabaaaaaabnaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
dcaaaaakccaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaacaaaaaaelaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaabnaaaaai
mcaabaaaacaaaaaafgijcaaaaaaaaaaaaeaaaaaafgafbaaaacaaaaaaabaaaaah
mcaabaaaacaaaaaapgapbaaaabaaaaaakgaobaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaamdcaabaaaadaaaaaa
jgifcaaaaaaaaaaaaeaaaaaajgifcaaaaaaaaaaaaeaaaaaapgapbaiaebaaaaaa
abaaaaaaelaaaaafdcaabaaaadaaaaaaegaabaaaadaaaaaaaaaaaaaifcaabaaa
adaaaaaapgapbaaaaaaaaaaaagabbaiaebaaaaaaadaaaaaaddaaaaahicaabaaa
abaaaaaaakaabaaaadaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaaaaaaaaa
ckaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaahicaabaaa
abaaaaaadkaabaaaaaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaacaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaa
adaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaaeaaaaaakgakbaaaacaaaaaa
egacbaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaa
adaaaaaaaaaaaaajicaabaaaadaaaaaabkaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaadcaaaaakccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaiccaabaaaaeaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaa
adaaaaaaaaaaaaaiccaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaa
acaaaaaadcaaaaakccaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaaadaaaaaa
ckiacaaaaaaaaaaaaeaaaaaaaaaaaaaiccaabaaaadaaaaaabkaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaaaacaaaajicaabaaaadaaaaaaakaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaaeaaaaaadcaaaaajccaabaaaacaaaaaadkaabaaa
adaaaaaabkaabaaaadaaaaaabkaabaaaacaaaaaadeaaaaahccaabaaaadaaaaaa
bkaabaaaacaaaaaaakaabaaaadaaaaaaddaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaiadodcaaaaajecaabaaaafaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaeadpakaabaaaadaaaaaadcaaaaajccaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaaaabaaaaaackaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaafaaaaaaaaaaaaaiccaabaaaacaaaaaackaabaaaacaaaaaa
bkaabaiaebaaaaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
bkaabaiaebaaaaaaacaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaadhaaaaajocaabaaaacaaaaaapgapbaaa
acaaaaaaagajbaaaafaaaaaaagajbaaaaaaaaaaaddaaaaahbcaabaaaaeaaaaaa
akaabaaaaaaaaaaabkaabaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aeaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaa
dbaaaaaiecaabaaaaaaaaaaaakaabaaaacaaaaaackiacaaaaaaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadodcaaaaajecaabaaa
aeaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeadpbkaabaaaaaaaaaaadhaaaaaj
hcaabaaaaaaaaaaakgakbaaaaaaaaaaabgagbaaaaeaaaaaaggalbaaaacaaaaaa
dgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaeaaaaaackiacaaaaaaaaaaaaeaaaaaaaocaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 91 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c6, 1.00000000, 0.00000000, 0.25000000, 0.75000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord6 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.z, v3, r0
dp3 r0.w, v3, v3
mad r1.x, -r1.z, r1.z, r0.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.w, r1.x, r1.x
mad r1.y, c4.x, c4.x, -r1.w
rsq r1.y, r1.y
rcp r2.y, r1.y
add r1.y, -r1.x, c4.x
rsq r0.w, r0.w
cmp r2.x, r1.z, c6, c6.y
cmp r1.y, r1, c6.x, c6
mul_pp r1.y, r1, r2.x
texldp r2.x, v0, s0
mad r2.x, r2, c1.z, c1.w
add r2.y, r1.z, -r2
rcp r2.x, r2.x
cmp r1.y, -r1, r2.x, r2
rcp r0.w, r0.w
add r2.y, r0.w, -c5.x
cmp r2.z, r1, c6.y, c6.x
cmp r2.y, r2, c6, c6.x
mul_pp r2.y, r2, r2.z
min r1.y, r1, r2.x
if_gt r2.y, c6.y
mad r1.z, r0.w, r0.w, -r1.w
mad r1.x, c5, c5, -r1.w
rsq r1.z, r1.z
rsq r1.x, r1.x
rcp r1.z, r1.z
rcp r1.x, r1.x
add r1.x, r1, -r1.z
min r1.y, r1.x, r1
mad r0.xyz, r1.y, r0, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
max r0.y, r0.w, r0.x
mul r0.y, r0, c6.z
min r0.x, r0.w, r0
mad r0.x, r0, c6.w, r0.y
else
mad r1.w, c5.x, c5.x, -r1
rsq r1.w, r1.w
rcp r1.w, r1.w
add r2.x, r1.z, r1.w
min r2.y, r2.x, r1
add r1.w, r1.z, -r1
mad r0.xyz, r2.y, r0, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
add r2.x, r2, -r1.w
add r0.y, -r1, r2
add r0.z, r1.x, -c5.x
mad r0.z, r0.y, r0, c5.x
add_sat r0.y, -r0.w, c5.x
add r2.z, r0.w, -r0
add r0.w, -r1.x, c5.x
mad r1.w, r0.y, r2.x, r1
mad r0.z, r0.y, r2, r0
rcp r0.x, r0.x
max r2.x, r0, r0.z
cmp r1.x, r1.z, c6, c6.y
cmp r0.w, r0, c6.x, c6.y
mul_pp r0.w, r0, r1.x
cmp r1.x, -r0.w, c6.y, r1.w
add r1.z, -r1.x, r2.y
min r1.w, r1.x, r1.y
add r1.w, r1, -r1.z
mad r0.y, r0, r1.w, r1.z
mul r2.x, r2, c6.z
min r0.x, r0, r0.z
mad r0.x, r0, c6.w, r2
cmp r0.x, -r0.w, c5, r0
cmp r1.y, -r0.w, r1, r0
endif
mov r0.y, c5.x
add r0.y, -c4.x, r0
rcp r0.y, r0.y
add r0.x, r0, -c4
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c6.x
mov_sat r0.x, r1
mul r0.y, r0, c3.x
mul r0.x, r0, r1.y
mul r0.x, r0, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" }
ConstBuffer "$Globals" 96 // 76 used size, 8 vars
Vector 48 [_Color] 4
Float 64 [_Visibility]
Float 68 [_OceanRadius]
Float 72 [_SphereRadius]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 73 instructions, 7 temp regs, 0 temp arrays:
// ALU 62 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjcngaagekecoiieeekndccmnakdpkbjmabaaaaaaimakaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaaaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaaiaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdmajaaaaeaaaaaaaepacaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaabnaaaaahccaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaahecaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaakicaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaabnaaaaaidcaabaaaacaaaaaajgifcaaaaaaaaaaa
aeaaaaaapgapbaaaabaaaaaaabaaaaahdcaabaaaacaaaaaafgafbaaaabaaaaaa
egaabaaaacaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaammcaabaaaacaaaaaafgijcaaaaaaaaaaaaeaaaaaafgijcaaa
aaaaaaaaaeaaaaaafgafbaiaebaaaaaaabaaaaaaelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaabaaaaaaogakbaia
ebaaaaaaacaaaaaadhaaaaajccaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
adaaaaaadkaabaaaaaaaaaaaddaaaaahbcaabaaaaeaaaaaadkaabaaaaaaaaaaa
bkaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
acaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
ddaaaaahccaabaaaabaaaaaaakaabaaaaeaaaaaadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaadkaabaaaaaaaaaaadcaaaaak
ncaabaaaadaaaaaafgafbaaaabaaaaaaagajbaaaaaaaaaaaagijcaaaabaaaaaa
aeaaaaaaaaaaaaaincaabaaaadaaaaaaagaobaaaadaaaaaaagbjbaiaebaaaaaa
adaaaaaabaaaaaahbcaabaaaacaaaaaaigadbaaaadaaaaaaigadbaaaadaaaaaa
elaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaajecaabaaaacaaaaaa
dkaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
elaaaaafmcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaiccaabaaaafaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaa
akaabaiaebaaaaaaaeaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaaaacaaaaaackiacaaaaaaaaaaaaeaaaaaaaaaaaaai
ecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaaaacaaaaj
icaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaaaeaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaadkaabaaa
abaaaaaadeaaaaahecaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
ddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaah
bcaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadodcaaaaajecaabaaa
agaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaeadpakaabaaaacaaaaaadgaaaaaf
ccaabaaaaeaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaeaaaaaackiacaaa
aaaaaaaaaeaaaaaadcaaaaajccaabaaaagaaaaaadkaabaaaacaaaaaadkaabaaa
aaaaaaaabkaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaaakaabaaaaeaaaaaa
bkaabaaaagaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaia
ebaaaaaaagaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaajbcaabaaaagaaaaaadkaabaaaacaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaadhaaaaajhcaabaaaacaaaaaafgafbaaaacaaaaaa
egacbaaaagaaaaaaegacbaaaaeaaaaaaddaaaaahbcaabaaaafaaaaaaakaabaaa
aeaaaaaabkaabaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaafaaaaaa
egacbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadeaaaaahccaabaaaaaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaadbaaaaai
ecaabaaaaaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaaeaaaaaaabaaaaah
ecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadodcaaaaajecaabaaaafaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaeadpbkaabaaaaaaaaaaadhaaaaajhcaabaaa
aaaaaaaakgakbaaaaaaaaaaabgagbaaaafaaaaaabgagbaaaacaaaaaadgcaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakecaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaaaeaaaaaackiacaaaaaaaaaaaaeaaaaaaaocaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" }
"!!GLES3"
}

}

#LINE 153

	
		}
		
	} 
	
}
}
