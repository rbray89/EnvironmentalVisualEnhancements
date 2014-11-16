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
		cull Front
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 36 to 36
//   d3d11 - ALU: 34 to 34, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
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
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  float sphereDist_2;
  vec4 color_3;
  color_3 = _Color;
  float tmpvar_4;
  tmpvar_4 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  sphereDist_2 = 0.0;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD7, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = sqrt(dot (xlv_TEXCOORD7, xlv_TEXCOORD7));
  if ((tmpvar_7 > _SphereRadius)) {
    sphereDist_2 = 0.0;
  } else {
    if ((tmpvar_5 < 0.0)) {
      vec3 p_8;
      p_8 = (_WorldSpaceCameraPos - xlv_TEXCOORD2);
      sphereDist_2 = (sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_6, 2.0))) - sqrt((pow (sqrt(dot (p_8, p_8)), 2.0) - pow (tmpvar_6, 2.0))));
    } else {
      if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
        sphereDist_2 = (sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_6, 2.0))) + tmpvar_5);
      };
    };
  };
  float tmpvar_9;
  tmpvar_9 = min (sphereDist_2, tmpvar_4);
  oceanSphereDist_1 = tmpvar_9;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_6, 2.0))));
  };
  float tmpvar_10;
  tmpvar_10 = (min (oceanSphereDist_1, tmpvar_9) * _Visibility);
  color_3.w = (_Color.w * mix (tmpvar_10, min (tmpvar_10, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = color_3;
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
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c15, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r0.x, c8.w
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
mul o7.xyz, r1.z, r4
add r4.xyz, -r0, c12
mov o3.xyz, r0
dp4 r0.x, v0, c2
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r3.xyz, r1.xyww, c15.x
mul r3.y, r3, c13.x
mad o1.xy, r3.z, c14.zwzw, r3
dp3 r2.w, r4, r4
rcp r3.w, r1.z
rsq r1.z, r2.w
add r3.xyz, -r2, c12
rcp r1.z, r1.z
add o6.x, r1.z, -r3.w
dp3 r2.w, r3, r3
rsq r2.w, r2.w
dp4 r1.z, v0, c6
mov o0, r1
mul o4.xyz, r2.w, r3
mov o2.xyz, r2
rcp o5.x, r2.w
mov o8.xyz, -r4
mov o1.z, -r0.x
mov o1.w, r0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 40 instructions, 2 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedachefpdpejdlhjnngocgeiflhiangjlmabaaaaaaaaahaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaiahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmafaaaaeaaaabaafhabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadiccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
hccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
iccabaaaacaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaagaaaaaaegacbaaaabaaaaaaelaaaaafbcaabaaaabaaaaaadkaabaaa
abaaaaaaaaaaaaaiiccabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
apaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float oceanSphereDist_2;
  highp float sphereDist_3;
  highp float depth_4;
  mediump vec4 color_5;
  color_5 = _Color;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * depth_4) + _ZBufferParams.w)));
  depth_4 = tmpvar_7;
  sphereDist_3 = 0.0;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD7, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  highp float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_8 * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD7, xlv_TEXCOORD7));
  if ((tmpvar_10 > _SphereRadius)) {
    sphereDist_3 = 0.0;
  } else {
    if ((tmpvar_8 < 0.0)) {
      highp vec3 p_11;
      p_11 = (_WorldSpaceCameraPos - xlv_TEXCOORD2);
      sphereDist_3 = (sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_9, 2.0))) - sqrt((pow (sqrt(dot (p_11, p_11)), 2.0) - pow (tmpvar_9, 2.0))));
    } else {
      if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
        sphereDist_3 = (sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_9, 2.0))) + tmpvar_8);
      };
    };
  };
  highp float tmpvar_12;
  tmpvar_12 = min (sphereDist_3, tmpvar_7);
  depth_4 = tmpvar_12;
  oceanSphereDist_2 = tmpvar_12;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_2 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_9, 2.0))));
  };
  highp float tmpvar_13;
  tmpvar_13 = (min (oceanSphereDist_2, tmpvar_12) * _Visibility);
  depth_4 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (color_5.w * mix (tmpvar_13, min (tmpvar_13, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  color_5.w = tmpvar_14;
  tmpvar_1 = color_5;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float oceanSphereDist_2;
  highp float sphereDist_3;
  highp float depth_4;
  mediump vec4 color_5;
  color_5 = _Color;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * depth_4) + _ZBufferParams.w)));
  depth_4 = tmpvar_7;
  sphereDist_3 = 0.0;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD7, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  highp float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_8 * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD7, xlv_TEXCOORD7));
  if ((tmpvar_10 > _SphereRadius)) {
    sphereDist_3 = 0.0;
  } else {
    if ((tmpvar_8 < 0.0)) {
      highp vec3 p_11;
      p_11 = (_WorldSpaceCameraPos - xlv_TEXCOORD2);
      sphereDist_3 = (sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_9, 2.0))) - sqrt((pow (sqrt(dot (p_11, p_11)), 2.0) - pow (tmpvar_9, 2.0))));
    } else {
      if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
        sphereDist_3 = (sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_9, 2.0))) + tmpvar_8);
      };
    };
  };
  highp float tmpvar_12;
  tmpvar_12 = min (sphereDist_3, tmpvar_7);
  depth_4 = tmpvar_12;
  oceanSphereDist_2 = tmpvar_12;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_2 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_9, 2.0))));
  };
  highp float tmpvar_13;
  tmpvar_13 = (min (oceanSphereDist_2, tmpvar_12) * _Visibility);
  depth_4 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (color_5.w * mix (tmpvar_13, min (tmpvar_13, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  color_5.w = tmpvar_14;
  tmpvar_1 = color_5;
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 worldNormal;
    highp vec3 L;
};
#line 402
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
#line 422
#line 439
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
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 430
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.worldNormal = normalize((vertexPos - origin));
    o.scrPos = ComputeScreenPos( o.pos);
    #line 434
    o.altitude = (distance( origin, _WorldSpaceCameraPos) - distance( origin, vertexPos));
    o.L = (origin - _WorldSpaceCameraPos);
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
out highp vec3 xlv_TEXCOORD7;
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
    xlv_TEXCOORD6 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD7 = vec3(xl_retval.L);
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 worldNormal;
    highp vec3 L;
};
#line 402
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
#line 422
#line 439
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 443
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    highp float tc = dot( IN.L, normalize((IN.worldVert - _WorldSpaceCameraPos)));
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 447
    highp float Llength = length(IN.L);
    if ((Llength > _SphereRadius)){
        sphereDist = 0.0;
    }
    else{
        if ((tc < 0.0)){
            #line 454
            highp float tlc = sqrt((pow( _SphereRadius, 2.0) - pow( d, 2.0)));
            highp float td = sqrt((pow( distance( _WorldSpaceCameraPos, IN.worldOrigin), 2.0) - pow( d, 2.0)));
            sphereDist = (tlc - td);
        }
        else{
            if (((d <= _SphereRadius) && (tc >= 0.0))){
                #line 460
                highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - pow( d, 2.0)));
                sphereDist = (tlc_1 + tc);
            }
        }
    }
    depth = min( sphereDist, depth);
    #line 464
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc_2 = sqrt((pow( _OceanRadius, 2.0) - pow( d, 2.0)));
        #line 468
        oceanSphereDist = (tc - tlc_2);
    }
    depth = min( oceanSphereDist, depth);
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    #line 472
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    #line 476
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    depth *= _Visibility;
    color.w *= mix( depth, min( depth, rim), xll_saturate_f(IN.altitude));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in highp float xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
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
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD6);
    xlt_IN.L = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 71 to 71, TEX: 1 to 1
//   d3d11 - ALU: 48 to 48, TEX: 1 to 1, FLOW: 1 to 1
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
Float 4 [_FalloffPow]
Float 5 [_FalloffScale]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 71 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord5 v4.x
dcl_texcoord6 v5.xyz
dcl_texcoord7 v6.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.y, v6, r1
dp3 r0.x, v6, v6
mad r0.y, -r1, r1, r0.x
rsq r0.y, r0.y
rcp r0.w, r0.y
add r0.y, -r0.w, c7.x
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.x, -r0, c7
cmp r0.x, r0, c8.y, c8
abs_pp r2.x, r0
cmp r1.w, r1.y, c8.x, c8.y
cmp r0.y, r0, c8.x, c8
mul_pp r1.z, r1.w, r0.y
cmp r1.x, r1.y, c8.y, c8
abs_pp r0.y, r1.x
cmp_pp r2.x, -r2, c8, c8.y
cmp_pp r2.y, -r0, c8.x, c8
add r0.xyz, v2, -c0
dp3 r0.x, r0, r0
mul_pp r2.y, r2.x, r2
mul_pp r0.y, r2, r1.z
mul r1.z, r0.w, r0.w
rsq r0.x, r0.x
rcp r0.z, r0.x
mad r0.z, r0, r0, -r1
mad r0.x, c7, c7, -r1.z
rsq r2.y, r0.z
rsq r0.x, r0.x
rcp r0.z, r0.x
rcp r0.x, r2.y
add r2.y, -r0.x, r0.z
mul_pp r1.x, r2, r1
texldp r0.x, v0, s0
mad r2.x, r0, c1.z, c1.w
add r0.x, r1.y, r0.z
cmp r1.x, -r1, c8.y, r2.y
cmp r0.x, -r0.y, r1, r0
rcp r0.z, r2.x
min r1.x, r0, r0.z
mov r0.xyz, v5
dp3_sat r0.y, v3, r0
add r0.w, -r0, c6.x
cmp r0.x, r0.w, c8, c8.y
mul_pp r1.w, r0.x, r1
mul r2.x, r0.y, c5
pow_sat r0, r2.x, c4.x
mad r0.y, c6.x, c6.x, -r1.z
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r1.y, r1, -r0.x
mul r1.z, r0, c5.x
pow_sat r0, r1.z, c4.x
cmp r0.y, -r1.w, r1.x, r1
mov r0.z, r0.x
min r0.y, r0, r1.x
mul r0.x, r0.y, c3
min r0.y, r0.x, r0.z
add r0.z, r0.y, -r0.x
mov_sat r0.y, v4.x
mad r0.x, r0.y, r0.z, r0
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 112 // 100 used size, 13 vars
Vector 48 [_Color] 4
Float 64 [_Visibility]
Float 68 [_FalloffPow]
Float 72 [_FalloffScale]
Float 92 [_OceanRadius]
Float 96 [_SphereRadius]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 55 instructions, 3 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbfbejpdnhmnmhfidgflmaekemhmfnaniabaaaaaaieaiaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaaaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaaiaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcbmahaaaaeaaaaaaamhabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaagaaaaaaegacbaaaaaaaaaaa
bnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
elaaaaafmcaabaaaaaaaaaaakgaobaaaaaaaaaaadbaaaaaiecaabaaaaaaaaaaa
akiacaaaaaaaaaaaagaaaaaackaabaaaaaaaaaaabnaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaagaaaaaadkaabaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaaakiacaaaaaaaaaaa
agaaaaaaakiacaaaaaaaaaaaagaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaam
ccaabaaaabaaaaaadkiacaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaa
bkaabaiaebaaaaaaabaaaaaaelaaaaafgcaabaaaabaaaaaafgagbaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
aaaaaaahicaabaaaabaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaadcaaaaakicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaabnaaaaai
icaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaackaabaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahmcaabaaaaaaaaaaa
agbebaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalecaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
ckaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadhaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaa
akaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaabacaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaafaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaa
cpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaabjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
aeaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaabjaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaaeaaaaaackaabaaaaaaaaaaadgcaaaafecaabaaaaaaaaaaadkbabaaa
adaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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

#LINE 147

	
		}
		
		Pass {

		Lighting On
		cull Back
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 36 to 36
//   d3d11 - ALU: 34 to 34, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
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
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  float sphereDist_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  sphereDist_2 = 0.0;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD7, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_6 * tmpvar_6)));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_7, 2.0))));
  };
  float tmpvar_8;
  tmpvar_8 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_8;
  if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
    float tmpvar_9;
    tmpvar_9 = sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_7, 2.0)));
    sphereDist_2 = (tmpvar_6 - tmpvar_9);
    depth_3 = min ((tmpvar_6 + tmpvar_9), tmpvar_8);
  };
  float tmpvar_10;
  tmpvar_10 = (mix (0.0, (depth_3 - sphereDist_2), clamp (sphereDist_2, 0.0, 1.0)) * _Visibility);
  depth_3 = tmpvar_10;
  color_4.w = (_Color.w * mix (tmpvar_10, min (tmpvar_10, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c15, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r0.x, c8.w
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
mul o7.xyz, r1.z, r4
add r4.xyz, -r0, c12
mov o3.xyz, r0
dp4 r0.x, v0, c2
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r3.xyz, r1.xyww, c15.x
mul r3.y, r3, c13.x
mad o1.xy, r3.z, c14.zwzw, r3
dp3 r2.w, r4, r4
rcp r3.w, r1.z
rsq r1.z, r2.w
add r3.xyz, -r2, c12
rcp r1.z, r1.z
add o6.x, r1.z, -r3.w
dp3 r2.w, r3, r3
rsq r2.w, r2.w
dp4 r1.z, v0, c6
mov o0, r1
mul o4.xyz, r2.w, r3
mov o2.xyz, r2
rcp o5.x, r2.w
mov o8.xyz, -r4
mov o1.z, -r0.x
mov o1.w, r0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 40 instructions, 2 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedachefpdpejdlhjnngocgeiflhiangjlmabaaaaaaaaahaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaiahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmafaaaaeaaaabaafhabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadiccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
hccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
iccabaaaacaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaagaaaaaaegacbaaaabaaaaaaelaaaaafbcaabaaaabaaaaaadkaabaaa
abaaaaaaaaaaaaaiiccabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
apaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float oceanSphereDist_2;
  highp float sphereDist_3;
  highp float depth_4;
  mediump vec4 color_5;
  color_5 = _Color;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * depth_4) + _ZBufferParams.w)));
  depth_4 = tmpvar_7;
  sphereDist_3 = 0.0;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD7, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  highp float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_8 * tmpvar_8)));
  oceanSphereDist_2 = tmpvar_7;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_2 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_9, 2.0))));
  };
  highp float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_2, tmpvar_7);
  depth_4 = tmpvar_10;
  if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
    highp float tmpvar_11;
    tmpvar_11 = sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_9, 2.0)));
    sphereDist_3 = (tmpvar_8 - tmpvar_11);
    depth_4 = min ((tmpvar_8 + tmpvar_11), tmpvar_10);
  };
  highp float tmpvar_12;
  tmpvar_12 = (mix (0.0, (depth_4 - sphereDist_3), clamp (sphereDist_3, 0.0, 1.0)) * _Visibility);
  depth_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (color_5.w * mix (tmpvar_12, min (tmpvar_12, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  color_5.w = tmpvar_13;
  tmpvar_1 = color_5;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float oceanSphereDist_2;
  highp float sphereDist_3;
  highp float depth_4;
  mediump vec4 color_5;
  color_5 = _Color;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * depth_4) + _ZBufferParams.w)));
  depth_4 = tmpvar_7;
  sphereDist_3 = 0.0;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD7, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  highp float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_8 * tmpvar_8)));
  oceanSphereDist_2 = tmpvar_7;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_2 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_9, 2.0))));
  };
  highp float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_2, tmpvar_7);
  depth_4 = tmpvar_10;
  if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
    highp float tmpvar_11;
    tmpvar_11 = sqrt((pow (_SphereRadius, 2.0) - pow (tmpvar_9, 2.0)));
    sphereDist_3 = (tmpvar_8 - tmpvar_11);
    depth_4 = min ((tmpvar_8 + tmpvar_11), tmpvar_10);
  };
  highp float tmpvar_12;
  tmpvar_12 = (mix (0.0, (depth_4 - sphereDist_3), clamp (sphereDist_3, 0.0, 1.0)) * _Visibility);
  depth_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (color_5.w * mix (tmpvar_12, min (tmpvar_12, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  color_5.w = tmpvar_13;
  tmpvar_1 = color_5;
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 worldNormal;
    highp vec3 L;
};
#line 402
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
#line 422
#line 439
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
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 430
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.worldNormal = normalize((vertexPos - origin));
    o.scrPos = ComputeScreenPos( o.pos);
    #line 434
    o.altitude = (distance( origin, _WorldSpaceCameraPos) - distance( origin, vertexPos));
    o.L = (origin - _WorldSpaceCameraPos);
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
out highp vec3 xlv_TEXCOORD7;
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
    xlv_TEXCOORD6 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD7 = vec3(xl_retval.L);
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 worldNormal;
    highp vec3 L;
};
#line 402
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
#line 422
#line 439
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 443
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    highp float tc = dot( IN.L, normalize((IN.worldVert - _WorldSpaceCameraPos)));
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 447
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - pow( d, 2.0)));
        #line 451
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float Llength = length(IN.L);
    #line 455
    if (((d <= _SphereRadius) && (tc >= 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - pow( d, 2.0)));
        sphereDist = (tc - tlc_1);
        #line 459
        depth = min( (tc + tlc_1), depth);
    }
    depth = mix( 0.0, (depth - sphereDist), xll_saturate_f(sphereDist));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    #line 463
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    #line 467
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    depth *= _Visibility;
    color.w *= mix( depth, min( depth, rim), xll_saturate_f(IN.altitude));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in highp float xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
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
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD6);
    xlt_IN.L = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 54 to 54, TEX: 1 to 1
//   d3d11 - ALU: 44 to 44, TEX: 1 to 1, FLOW: 1 to 1
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
Float 4 [_FalloffPow]
Float 5 [_FalloffScale]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 54 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord5 v4.x
dcl_texcoord6 v5.xyz
dcl_texcoord7 v6.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r1.x, v6, r1
dp3 r0.x, v6, v6
mad r0.x, -r1, r1, r0
rsq r0.x, r0.x
rcp r2.x, r0.x
mul r0.x, r2, r2
mad r0.y, c6.x, c6.x, -r0.x
rsq r0.z, r0.y
add r0.y, -r2.x, c6.x
rcp r0.z, r0.z
add r1.z, r1.x, -r0
mad r0.z, c7.x, c7.x, -r0.x
rsq r0.z, r0.z
texldp r0.x, v0, s0
cmp r0.w, r1.x, c8.x, c8.y
cmp r0.y, r0, c8.x, c8
rcp r1.y, r0.z
mad r0.x, r0, c1.z, c1.w
rcp r0.z, r0.x
mul_pp r0.y, r0.w, r0
cmp r0.y, -r0, r0.z, r1.z
add r0.x, r1, r1.y
min r1.z, r0.y, r0
min r1.w, r1.z, r0.x
mov r0.xyz, v5
dp3_sat r0.y, v3, r0
add r2.x, -r2, c7
cmp r0.x, r2, c8, c8.y
mul_pp r2.x, r0, r0.w
mul r2.y, r0, c5.x
pow_sat r0, r2.y, c4.x
cmp r0.z, -r2.x, r1, r1.w
add r0.y, r1.x, -r1
cmp r1.x, -r2, c8.y, r0.y
add r1.y, -r1.x, r0.z
mul r1.z, r0.x, c5.x
pow_sat r0, r1.z, c4.x
mov_sat r0.y, r1.x
mov r0.z, r0.x
mul r0.y, r0, r1
mul r0.x, r0.y, c3
min r0.y, r0.x, r0.z
add r0.z, r0.y, -r0.x
mov_sat r0.y, v4.x
mad r0.x, r0.y, r0.z, r0
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 112 // 100 used size, 13 vars
Vector 48 [_Color] 4
Float 64 [_Visibility]
Float 68 [_FalloffPow]
Float 72 [_FalloffScale]
Float 92 [_OceanRadius]
Float 96 [_SphereRadius]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 52 instructions, 3 temp regs, 0 temp arrays:
// ALU 42 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbjbplobjlabnanngihcofamkpfghmfklabaaaaaapiahaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaaaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaaiaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjaagaaaaeaaaaaaakeabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaaegacbaaa
abaaaaaadcaaaaakccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkiacaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaa
dkaabaiaebaaaaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaaakiacaaaaaaaaaaa
agaaaaaaakiacaaaaaaaaaaaagaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaabnaaaaaiccaabaaaabaaaaaadkiacaaaaaaaaaaaafaaaaaabkaabaaa
aaaaaaaabnaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaabkaabaaa
aaaaaaaabnaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaadhaaaaajbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaaddaaaaah
bcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaiccaabaaaacaaaaaa
dkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaddaaaaahbcaabaaaacaaaaaa
akaabaaaabaaaaaaakaabaaaaaaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaafgafbaaaaaaaaaaabgafbaaaacaaaaaa
bgafbaaaabaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaadgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaabacaaaahecaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaafaaaaaadiaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaacpaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaddaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaacpaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaeaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
ddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaackaabaaa
aaaaaaaadgcaaaafecaabaaaaaaaaaaadkbabaaaadaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaag
hccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
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

#LINE 266

	
		}
	} 
	
}
}
