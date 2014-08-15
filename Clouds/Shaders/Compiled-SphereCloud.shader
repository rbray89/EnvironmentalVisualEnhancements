Shader "Sphere/Cloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_MainOffset ("Main Offset", Vector) = (0,0,0,0)
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Vector) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,1)) = 1
		_RimDistSub ("Rim Distance Sub", Range(0,2)) = 1.01
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
//   d3d9 - ALU: 37 to 47
//   d3d11 - ALU: 35 to 47, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8
def c23, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c23.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o8.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
mov o8.z, -r0.x
mov o8.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
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
// 48 instructions, 3 temp regs, 0 temp arrays:
// ALU 43 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedikhccgaofmjijlknjgofbbcaejdikpfkabaaaaaafmaiaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
liagaaaaeaaaabaakoabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaaficcabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
pgbpbaaaaaaaaaaaegaobaaaacaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaag
hccabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 417
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec4 projPos;
};
#line 410
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 430
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
#line 430
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 434
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 438
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 442
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 447
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 417
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec4 projPos;
};
#line 410
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 430
#line 449
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 451
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 455
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 458
lowp vec4 frag( in v2f IN ) {
    #line 460
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 464
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 468
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 472
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 476
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 480
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 484
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 488
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    #line 492
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_Rotation]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord8 o7
def c19, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c19.x
mul r3.y, r3, c17.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o7.xy, r3.z, c18.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c14
dp4 r1.x, v0, c12
dp4 r1.y, v0, c13
dp4 r1.w, v0, c15
dp4 r1.w, r1, r1
rsq r2.w, r1.w
add r3.xyz, -r2, c16
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r1.xyz, r2.w, r1
mov o5.xyz, -r1
mul o6.xyz, r1.w, r3
mov o1.xyz, r2
rcp o3.x, r1.w
mov o7.z, -r0.x
mov o7.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 224 // 208 used size, 17 vars
Matrix 144 [_Rotation] 4
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
// 40 instructions, 3 temp regs, 0 temp arrays:
// ALU 35 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlieoiaolfddeionopblblbfgkdakjngmabaaaaaaaiahaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaaiaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchmafaaaaeaaaabaafpabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaaficcabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaajaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaaaaaaaaaegaobaaa
acaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaapgbpbaaa
aaaaaaaaegaobaaaacaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaagaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaagaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 projPos;
};
#line 408
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 397
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 401
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 405
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 427
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
#line 427
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 431
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 435
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 439
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    #line 443
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 projPos;
};
#line 408
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 397
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 401
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 405
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 427
#line 445
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 447
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 451
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 454
lowp vec4 frag( in v2f IN ) {
    #line 456
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 460
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 464
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 468
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 472
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 476
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 480
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 484
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    #line 488
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8
def c23, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c23.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o8.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.w, r1, c15
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
mov o8.z, -r0.x
mov o8.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
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
// 48 instructions, 3 temp regs, 0 temp arrays:
// ALU 43 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaajcbehdcmfbnaaijmalcnoabjhidaciabaaaaaafmaiaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
liagaaaaeaaaabaakoabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaaficcabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
pgbpbaaaaaaaaaaaegaobaaaacaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaag
hccabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 326
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 426
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 projPos;
};
#line 419
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 336
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 349
#line 357
#line 371
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 404
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 408
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 412
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 416
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
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
#line 439
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 443
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 447
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 451
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 456
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 326
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 426
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 projPos;
};
#line 419
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 336
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 349
#line 357
#line 371
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 404
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 408
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 412
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 416
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 439
#line 458
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 460
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 464
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 473
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 477
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 481
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 485
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 489
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 493
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 497
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    #line 501
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8
def c23, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c23.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o8.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
mov o8.z, -r0.x
mov o8.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
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
// 48 instructions, 3 temp regs, 0 temp arrays:
// ALU 43 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedikhccgaofmjijlknjgofbbcaejdikpfkabaaaaaafmaiaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
liagaaaaeaaaabaakoabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaaficcabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
pgbpbaaaaaaaaaaaegaobaaaacaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaag
hccabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 318
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 418
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec4 projPos;
};
#line 411
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
#line 315
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 328
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 341
#line 349
#line 363
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 396
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 400
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 404
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 408
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 431
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
#line 431
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 435
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 439
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 443
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 448
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 318
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 418
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec4 projPos;
};
#line 411
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
#line 315
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 328
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 341
#line 349
#line 363
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 396
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 400
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 404
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 408
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 431
#line 450
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 452
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 456
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 459
lowp vec4 frag( in v2f IN ) {
    #line 461
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 465
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 469
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 473
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 477
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 481
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 485
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 489
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    #line 493
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8
def c23, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c23.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o8.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
mov o8.z, -r0.x
mov o8.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
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
// 48 instructions, 3 temp regs, 0 temp arrays:
// ALU 43 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecediimejbeodilmfpimolnlhhpfhonejnppabaaaaaafmaiaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
liagaaaaeaaaabaakoabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaaddccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaaficcabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
pgbpbaaaaaaaaaaaegaobaaaacaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaag
hccabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaa
acaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egaabaaaabaaaaaadcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaegaabaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaa
ahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 417
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
    highp vec4 projPos;
};
#line 410
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
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 430
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
#line 430
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 434
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 438
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 442
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 447
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 417
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
    highp vec4 projPos;
};
#line 410
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
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 430
#line 449
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 451
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 455
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 458
lowp vec4 frag( in v2f IN ) {
    #line 460
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 464
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 468
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 472
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 476
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 480
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 484
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 488
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    #line 492
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec2 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD6);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Matrix 20 [_Rotation]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c27, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c14
dp4 r2.y, v0, c13
dp4 r2.x, v0, c12
mov r0.x, c12.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c14.w
mov r0.y, c13.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c27.x
mul r3.y, r3, c25.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c26.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c22
dp4 r1.x, v0, c20
dp4 r1.y, v0, c21
dp4 r1.w, v0, c23
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c24
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c15
mul o6.xyz, r2.w, r3
dp4 o7.w, r1, c19
dp4 o7.z, r1, c18
dp4 o7.y, r1, c17
dp4 o7.x, r1, c16
dp4 o8.w, r1, c11
dp4 o8.z, r1, c10
dp4 o8.y, r1, c9
dp4 o8.x, r1, c8
mov o1.xyz, r2
rcp o3.x, r2.w
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 3 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednlmmilencnoglbinijflidgbilfienojabaaaaaaciajaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmahaaaaeaaaabaa
nlabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
acaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
abaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaagaaaaaaegiocaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
ajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaa
akaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaa
egiocaaaacaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 332
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 432
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 425
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 323
uniform sampler2D _LightTextureB0;
#line 328
#line 342
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 355
#line 363
#line 377
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 410
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 414
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 418
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 422
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 446
#line 466
#line 475
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
#line 446
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 450
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 454
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 458
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 462
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 332
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 432
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 425
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 323
uniform sampler2D _LightTextureB0;
#line 328
#line 342
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 355
#line 363
#line 377
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 410
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 414
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 418
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 422
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 446
#line 466
#line 475
#line 466
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 470
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 475
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 479
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 483
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 487
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 491
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 495
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 499
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 503
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 507
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 511
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Matrix 20 [_Rotation]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c27, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c14
dp4 r2.y, v0, c13
dp4 r2.x, v0, c12
mov r0.x, c12.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c14.w
mov r0.y, c13.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c27.x
mul r3.y, r3, c25.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c26.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c22
dp4 r1.x, v0, c20
dp4 r1.y, v0, c21
dp4 r1.w, v0, c23
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c24
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c15
mul o6.xyz, r2.w, r3
dp4 o7.w, r1, c19
dp4 o7.z, r1, c18
dp4 o7.y, r1, c17
dp4 o7.x, r1, c16
dp4 o8.w, r1, c11
dp4 o8.z, r1, c10
dp4 o8.y, r1, c9
dp4 o8.x, r1, c8
mov o1.xyz, r2
rcp o3.x, r2.w
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 3 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednlmmilencnoglbinijflidgbilfienojabaaaaaaciajaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmahaaaaeaaaabaa
nlabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
acaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
abaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaagaaaaaaegiocaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
ajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaa
akaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaa
egiocaaaacaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 333
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 433
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 426
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 323
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 343
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 356
#line 364
#line 378
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 411
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 415
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 419
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 423
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 447
#line 467
#line 476
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
#line 447
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 451
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 455
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 459
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 463
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 333
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 433
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 426
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 323
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 343
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 356
#line 364
#line 378
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 411
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 415
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 419
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 423
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 447
#line 467
#line 476
#line 467
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 471
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 476
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 480
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 484
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 488
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 492
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 496
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 500
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 504
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 508
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 512
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = o_9;
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_Rotation]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8
def c19, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.w, v0, c7
mov r1.w, r2
dp4 r3.z, v0, c10
dp4 r3.y, v0, c9
dp4 r3.x, v0, c8
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp4 r1.z, v0, c6
mov r2.z, c10.w
mov r2.x, c8.w
mov r2.y, c9.w
add r4.xyz, r3, -r2
dp3 r0.x, r4, r4
rsq r0.w, r0.x
mul r0.xyz, r1.xyww, c19.x
mul r0.y, r0, c17.x
mad r0.xy, r0.z, c18.zwzw, r0
mul o4.xyz, r0.w, r4
mov r0.zw, r1
mov o7, r0
mov o8.xy, r0
mov o0, r1
dp4 r0.z, v0, c14
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
dp4 r0.w, v0, c15
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r1.xyz, -r3, c16
mul r0.xyz, r1.w, r0
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mov o5.xyz, -r0
dp4 r0.x, v0, c2
mul o6.xyz, r0.w, r1
mov o1.xyz, r3
mov o2.xyz, r2
rcp o3.x, r0.w
mov o8.z, -r0.x
mov o8.w, r2
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 208 [_Rotation] 4
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
// 42 instructions, 3 temp regs, 0 temp arrays:
// ALU 36 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaadnfkfcjgeeeeikeahogikfmikfcdhbabaaaaaafmahaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
liafaaaaeaaaabaagoabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
pgbpbaaaaaaaaaaaegaobaaaacaaaaaabbaaaaahicaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaag
hccabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaafpccabaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaflccabaaaahaaaaaa
egambaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = o_9;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 423
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 416
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 405
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 409
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 413
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 436
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
#line 436
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 440
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 444
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 448
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 453
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 423
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 416
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 405
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 409
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 413
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 436
#line 455
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 457
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 461
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 464
lowp vec4 frag( in v2f IN ) {
    #line 466
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 470
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 474
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 478
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 482
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 486
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 490
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 494
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    #line 498
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD7 = o_9;
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 44 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c23, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.w, v0, c7
dp4 r3.z, v0, c10
dp4 r3.y, v0, c9
dp4 r3.x, v0, c8
mov r1.w, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp4 r1.z, v0, c6
mov r2.z, c10.w
mov r2.x, c8.w
mov r2.y, c9.w
add r4.xyz, r3, -r2
dp3 r0.x, r4, r4
rsq r0.w, r0.x
mul r0.xyz, r1.xyww, c23.x
mul r0.y, r0, c21.x
mad r0.xy, r0.z, c22.zwzw, r0
mul o4.xyz, r0.w, r4
mov r0.zw, r1
mov o8, r0
mov o9.xy, r0
mov o0, r1
dp4 r0.z, v0, c18
dp4 r0.x, v0, c16
dp4 r0.y, v0, c17
dp4 r0.w, v0, c19
dp4 r0.w, r0, r0
rsq r1.w, r0.w
mul r0.xyz, r1.w, r0
add r1.xyz, -r3, c20
dp3 r0.w, r1, r1
rsq r1.w, r0.w
mov o5.xyz, -r0
mov r0.xyz, r3
dp4 r0.w, v0, c11
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
dp4 r0.x, v0, c2
mul o6.xyz, r1.w, r1
mov o1.xyz, r3
mov o2.xyz, r2
rcp o3.x, r1.w
mov o9.z, -r0.x
mov o9.w, r2
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 352 // 336 used size, 19 vars
Matrix 80 [_LightMatrix0] 4
Matrix 272 [_Rotation] 4
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
// 50 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhkmbpphfecnamlkljdapdpaakplfcpaoabaaaaaalaaiaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpeagaaaaeaaaabaa
lnabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaaddccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
pcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaabcaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabbaaaaaaagbabaaaaaaaaaaaegaobaaa
acaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaakgbkbaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
beaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dgaaaaaghccabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
dcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaegaabaaa
acaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaahaaaaaakgakbaaa
abaaaaaaegaabaaaabaaaaaadcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaa
aiaaaaaapgapbaaaabaaaaaaegaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdcaabaaa
aaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafpccabaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaaflccabaaaaiaaaaaaegambaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = o_9;
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 325
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 425
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 418
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
#line 323
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 335
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 348
#line 356
#line 370
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 403
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 407
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 411
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 415
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 439
#line 459
#line 468
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
#line 439
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 443
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 447
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 451
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 455
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 325
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 425
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 418
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
#line 323
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 335
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 348
#line 356
#line 370
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 403
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 407
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 411
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 415
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 439
#line 459
#line 468
#line 459
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 463
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 468
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 472
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 476
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 480
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 484
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 488
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 492
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 496
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 500
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 504
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec2 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _LightPositionRange;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Vector 23 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c24, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c24.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
add o8.xyz, r2, -c23
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 49 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcplfkkmakdahdambnogdnngdnibcelobabaaaaaaleaiaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpiagaaaaeaaaabaa
loabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaa
agbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaa
bbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaiaebaaaaaa
acaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
aiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 330
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 430
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 423
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 340
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 353
#line 361
#line 375
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 408
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 412
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 416
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 420
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 444
#line 464
#line 473
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
#line 444
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 448
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 452
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 456
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 460
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 330
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 430
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 423
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 340
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 353
#line 361
#line 375
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 408
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 412
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 416
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 420
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 444
#line 464
#line 473
#line 464
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 468
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 473
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 477
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 481
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 485
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 489
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 493
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 497
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 501
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 505
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 509
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _LightPositionRange;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Vector 23 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c24, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c24.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
add o8.xyz, r2, -c23
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 49 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcplfkkmakdahdambnogdnngdnibcelobabaaaaaaleaiaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpiagaaaaeaaaabaa
loabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaa
agbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaa
bbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaiaebaaaaaa
acaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
aiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 331
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 431
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 424
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 341
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 354
#line 362
#line 376
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 409
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 413
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 417
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 421
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 445
#line 465
#line 474
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
#line 445
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 449
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 453
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 457
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 461
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 331
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 431
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 424
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 341
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 354
#line 362
#line 376
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 409
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 413
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 417
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 421
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 445
#line 465
#line 474
#line 465
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 469
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 474
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 478
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 482
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 486
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 490
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 494
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 498
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 502
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 506
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 510
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Matrix 20 [_Rotation]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c27, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c14
dp4 r2.y, v0, c13
dp4 r2.x, v0, c12
mov r0.x, c12.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c14.w
mov r0.y, c13.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c27.x
mul r3.y, r3, c25.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c26.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c22
dp4 r1.x, v0, c20
dp4 r1.y, v0, c21
dp4 r1.w, v0, c23
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c24
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c15
mul o6.xyz, r2.w, r3
dp4 o7.w, r1, c19
dp4 o7.z, r1, c18
dp4 o7.y, r1, c17
dp4 o7.x, r1, c16
dp4 o8.w, r1, c11
dp4 o8.z, r1, c10
dp4 o8.y, r1, c9
dp4 o8.x, r1, c8
mov o1.xyz, r2
rcp o3.x, r2.w
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 352 // 336 used size, 19 vars
Matrix 80 [_LightMatrix0] 4
Matrix 272 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 3 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddlhahfgmapgbjocmmefhpcbafjfphnjaabaaaaaaciajaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmahaaaaeaaaabaa
nlabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaabcaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
bbaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaapgbpbaaaaaaaaaaaegaobaaa
acaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
egiocaaaaaaaaaaaagaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
afaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaahaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaagaaaaaaegiocaaaaaaaaaaaaiaaaaaapgapbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
ajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaa
akaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaa
egiocaaaacaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 440
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 433
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 454
#line 474
#line 483
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
#line 454
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 458
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 462
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 466
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 470
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 440
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 433
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 454
#line 474
#line 483
#line 474
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 478
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 483
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 487
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 491
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 495
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 499
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 503
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 507
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 511
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 515
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 519
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 24 [_WorldSpaceCameraPos]
Vector 25 [_ProjectionParams]
Vector 26 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Matrix 20 [_Rotation]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c27, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c14
dp4 r2.y, v0, c13
dp4 r2.x, v0, c12
mov r0.x, c12.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c14.w
mov r0.y, c13.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c27.x
mul r3.y, r3, c25.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c26.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c22
dp4 r1.x, v0, c20
dp4 r1.y, v0, c21
dp4 r1.w, v0, c23
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c24
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c15
mul o6.xyz, r2.w, r3
dp4 o7.w, r1, c19
dp4 o7.z, r1, c18
dp4 o7.y, r1, c17
dp4 o7.x, r1, c16
dp4 o8.w, r1, c11
dp4 o8.z, r1, c10
dp4 o8.y, r1, c9
dp4 o8.x, r1, c8
mov o1.xyz, r2
rcp o3.x, r2.w
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 352 // 336 used size, 19 vars
Matrix 80 [_LightMatrix0] 4
Matrix 272 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 3 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddlhahfgmapgbjocmmefhpcbafjfphnjaabaaaaaaciajaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmahaaaaeaaaabaa
nlabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaabcaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
bbaaaaaaagbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabeaaaaaapgbpbaaaaaaaaaaaegaobaaa
acaaaaaabbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
egiocaaaaaaaaaaaagaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
afaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaaahaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaagaaaaaaegiocaaaaaaaaaaaaiaaaaaapgapbaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
ajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaacaaaaaa
akaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaa
egiocaaaacaaaaaaalaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 440
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 433
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 454
#line 474
#line 483
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
#line 454
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 458
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 462
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 466
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 470
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 440
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 433
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 454
#line 474
#line 483
#line 474
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 478
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 483
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 487
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 491
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 495
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 499
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 503
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 507
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 511
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 515
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 519
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _LightPositionRange;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Vector 23 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c24, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c24.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
add o8.xyz, r2, -c23
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 49 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcplfkkmakdahdambnogdnngdnibcelobabaaaaaaleaiaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpiagaaaaeaaaabaa
loabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaa
agbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaa
bbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaiaebaaaaaa
acaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
aiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 336
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 436
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 429
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
#line 346
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 359
#line 367
#line 381
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 414
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 418
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 422
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 426
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 450
#line 470
#line 479
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
#line 450
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 454
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 458
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 462
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 466
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 336
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 436
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 429
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
#line 346
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 359
#line 367
#line 381
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 414
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 418
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 422
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 426
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 450
#line 470
#line 479
#line 470
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 474
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 479
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 483
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 487
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 491
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 495
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 499
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 503
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 507
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 511
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 515
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
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
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Rotation;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _LightPositionRange;
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
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  color_2.w = (color_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Vector 23 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Matrix 16 [_Rotation]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c24, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.x, c8.w
mov r1.w, r0
dp4 r1.y, v0, c5
mov r0.z, c10.w
mov r0.y, c9.w
add r4.xyz, r2, -r0
dp3 r1.x, r4, r4
rsq r1.z, r1.x
dp4 r1.x, v0, c4
mul r3.xyz, r1.xyww, c24.x
mul r3.y, r3, c21.x
mul o4.xyz, r1.z, r4
dp4 r1.z, v0, c6
mov o0, r1
mad o9.xy, r3.z, c22.zwzw, r3
mov o2.xyz, r0
dp4 r0.x, v0, c2
dp4 r1.z, v0, c18
dp4 r1.x, v0, c16
dp4 r1.y, v0, c17
dp4 r1.w, v0, c19
dp4 r1.w, r1, r1
rsq r2.w, r1.w
mul r1.xyz, r2.w, r1
add r3.xyz, -r2, c20
dp3 r1.w, r3, r3
rsq r2.w, r1.w
mov o5.xyz, -r1
mov r1.xyz, r2
dp4 r1.w, v0, c11
mul o6.xyz, r2.w, r3
dp4 o7.z, r1, c14
dp4 o7.y, r1, c13
dp4 o7.x, r1, c12
mov o1.xyz, r2
rcp o3.x, r2.w
add o8.xyz, r2, -c23
mov o9.z, -r0.x
mov o9.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 288 // 272 used size, 18 vars
Matrix 16 [_LightMatrix0] 4
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 49 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcplfkkmakdahdambnogdnngdnibcelobabaaaaaaleaiaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaaeabaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpiagaaaaeaaaabaa
loabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaackaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaaoaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaa
agbabaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaa
bbaaaaahecaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaiaebaaaaaa
acaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
aiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Rotation;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
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
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  mediump float NdotL_3;
  mediump vec3 lightDirection_4;
  mediump vec3 ambientLighting_5;
  mediump float detailLevel_6;
  mediump vec4 detail_7;
  mediump vec4 detailZ_8;
  mediump vec4 detailY_9;
  mediump vec4 detailX_10;
  mediump vec4 main_11;
  highp vec2 uv_12;
  mediump vec4 color_13;
  highp float r_14;
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_14));
  uv_12.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_18;
  tmpvar_18 = (uv_12 + _MainOffset.xy);
  uv_12 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18.y);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18.y);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, tmpvar_18, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_10 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_9 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_8 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_8, detailX_10, tmpvar_29.xxxx);
  detail_7 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_7, detailY_9, tmpvar_29.yyyy);
  detail_7 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_6 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_11 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_6)));
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_36;
  p_36 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_37;
  tmpvar_37 = mix (0.0, tmpvar_33.w, mix (clamp (((_FadeScale * sqrt(dot (p_34, p_34))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_35, p_35)) - (_RimDistSub * sqrt(dot (p_36, p_36))))), 0.0, 1.0)));
  color_13.w = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = glstate_lightmodel_ambient.xyz;
  ambientLighting_5 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_4 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (dot (xlv_TEXCOORD3, lightDirection_4), 0.0, 1.0);
  NdotL_3 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (((_LightColor0.w * ((NdotL_3 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = clamp ((ambientLighting_5 + ((_MinLight + _LightColor0.xyz) * tmpvar_41)), 0.0, 1.0);
  color_13.xyz = (tmpvar_33.xyz * tmpvar_42);
  lowp float tmpvar_43;
  tmpvar_43 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (color_13.w * clamp ((_InvFade * (tmpvar_44 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_13.w = tmpvar_45;
  tmpvar_1 = color_13;
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
#line 337
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 437
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 430
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 347
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 360
#line 368
#line 382
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 415
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 419
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 423
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 427
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 451
#line 471
#line 480
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
#line 451
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 455
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 459
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 463
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 467
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
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
#line 337
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 437
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 430
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 347
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 360
#line 368
#line 382
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 415
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 419
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 423
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 427
uniform highp mat4 _Rotation;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 451
#line 471
#line 480
#line 471
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 475
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 480
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 484
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    #line 488
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    #line 492
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    #line 496
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 500
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 504
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 508
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp float depth = textureProj( _CameraDepthTexture, IN.projPos).x;
    #line 512
    depth = LinearEyeDepth( depth);
    highp float partZ = IN.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 516
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xlt_IN.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 110 to 110, TEX: 7 to 7
//   d3d11 - ALU: 94 to 94, TEX: 4 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcpdmdajbdhadpaedoadnkmhekpinldnkabaaaaaanaaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgianaaaaeaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaahaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaaj
icaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaa
aaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4_pp r0.y, c3, c3
rsq_pp r1.w, r0.y
mul_pp r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 224 // 212 used size, 17 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_MainOffset] 4
Vector 80 [_DetailOffset] 4
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 104 [_DetailScale]
Float 108 [_DetailDist]
Float 112 [_MinLight]
Float 116 [_FadeDist]
Float 120 [_FadeScale]
Float 124 [_RimDist]
Float 128 [_RimDistSub]
Float 208 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjojnhpijhngdaimhknikfpbkngjllhilabaaaaaaliaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaaiaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgianaaaaeaaaaaaafkadaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaa
ckbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
ddaaaaajccaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaa
aeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaa
aeaaaaaakgbjbaiaebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaa
aeaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaa
bnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdp
aaaaaaaibcaabaaaabaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadp
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaa
aaaaaaaaamaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaa
aaaaaaaaagbibaaaaeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaa
ogakbaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
aaaaaaaaagbibaaaaeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaa
ogakbaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaa
abaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaa
egiecaaaaaaaaaaaafaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
kgikcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaadiaaaaaidcaabaaaadaaaaaa
egaabaaaadaaaaaakgikcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaa
acaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaa
pgbpbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaadcaaaaajpcaabaaaabaaaaaa
agaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaa
agbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaa
jgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaa
abaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaadkiacaaaaaaaaaaaahaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaadaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaaaaaaaaaaaagaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaagaaaaaa
bjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaackaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaabaaaaaa
ckaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaia
ebaaaaaaagaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaa
aaaaaaaaanaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaagiacaaaaaaaaaaaahaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddfmgghjlhkpennjieeagepgpnklbccpiabaaaaaanaaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgianaaaaeaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaahaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaaj
icaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaa
aaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcpdmdajbdhadpaedoadnkmhekpinldnkabaaaaaanaaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgianaaaaeaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaahaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaaj
icaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaa
aaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4_pp r0.y, c3, c3
rsq_pp r1.w, r0.y
mul_pp r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmceaoldjgfjpieigfcjipfihpjihoenmabaaaaaanaaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgianaaaaeaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaahaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaaj
icaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaa
aaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhcechjgplfconcedogaoeijcnmeofenbabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhcechjgplfconcedogaoeijcnmeofenbabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4_pp r0.y, c3, c3
rsq_pp r1.w, r0.y
mul_pp r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddfmgghjlhkpennjieeagepgpnklbccpiabaaaaaanaaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgianaaaaeaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaahaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaaj
icaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaa
aaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4_pp r0.y, c3, c3
rsq_pp r1.w, r0.y
mul_pp r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 352 // 340 used size, 19 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_MainOffset] 4
Vector 208 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 240 [_MinLight]
Float 244 [_FadeDist]
Float 248 [_FadeScale]
Float 252 [_RimDist]
Float 256 [_RimDistSub]
Float 336 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfgnhbmakedglhneobdcdlabjkedgghkbabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaanaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
anaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
aoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaaoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaapaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
apaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabfaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaapaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedakpagndpilhaekpngdfcafchmpdhmienabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedakpagndpilhaekpngdfcafchmpdhmienabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 352 // 340 used size, 19 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_MainOffset] 4
Vector 208 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 240 [_MinLight]
Float 244 [_FadeDist]
Float 248 [_FadeScale]
Float 252 [_RimDist]
Float 256 [_RimDistSub]
Float 336 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedebbnmphmpkigeaibllaleggalpcphekmabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaanaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
anaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
aoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaaoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaapaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
apaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabfaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaapaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 352 // 340 used size, 19 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_MainOffset] 4
Vector 208 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 240 [_MinLight]
Float 244 [_FadeDist]
Float 248 [_FadeScale]
Float 252 [_RimDist]
Float 256 [_RimDistSub]
Float 336 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedebbnmphmpkigeaibllaleggalpcphekmabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaanaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
anaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
aoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaaoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaapaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
apaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabfaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaaapaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedakpagndpilhaekpngdfcafchmpdhmienabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_ZBufferParams]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [_LightColor0]
Vector 5 [_Color]
Vector 6 [_MainOffset]
Vector 7 [_DetailOffset]
Float 8 [_FalloffPow]
Float 9 [_FalloffScale]
Float 10 [_DetailScale]
Float 11 [_DetailDist]
Float 12 [_MinLight]
Float 13 [_FadeDist]
Float 14 [_FadeScale]
Float 15 [_RimDist]
Float 16 [_RimDistSub]
Float 17 [_InvFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 110 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c19, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c20, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c21, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c22, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
add r0.xy, v4.zyzw, c7
mul r0.xy, r0, c10.x
add r1.xy, v4, c7
dsx r3.zw, v4.xyxz
mul r3.zw, r3, r3
abs r2.xy, v4
abs r2.z, v4
max r1.z, r2.x, r2
rcp r1.w, r1.z
min r1.z, r2.x, r2
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c20, c20.z
mul r1.xy, r1, c10.x
mad r3.y, r3, r3.x, c20.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.y, r3.x, c21.x
mad r0.z, r0, r3.x, c21.y
mad r3.x, r0.z, r3, c21.z
add r0.xy, v4.zxzw, c7
mul r0.xy, r0, c10.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.y, r0, r1
mul r2.w, r3.x, r2
add r0.x, r2, -r2.z
add r0.y, -r2.w, c21.w
cmp r0.w, -r0.x, r2, r0.y
abs r0.x, v4.y
add r2.x, -r0.w, c18.z
cmp r0.w, v4.z, r0, r2.x
add r0.z, -r0.x, c18.y
mad r0.y, r0.x, c19.x, c19
mad r0.y, r0, r0.x, c18.w
rsq r0.z, r0.z
add_pp r2, -r1, c18.y
mad r0.x, r0.y, r0, c19.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.y, c18, c18.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c19.w, r0
mad r0.y, r0.x, c18.z, r0
cmp r0.z, v4.x, r0.w, -r0.w
mad r0.x, r0.z, c22, c22.y
mul r0.y, r0, c20.x
add r3.xy, r0, c6
dsy r0.xz, v4
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c22.x
mul r0.x, r3.z, c22
dsx r0.w, r3.y
dsy r0.y, r3
texldd r0, r3, s0, r0.zwzw, r0
mul r3.z, v2.x, c11.x
mul_sat r3.x, r3.z, c19.w
mad_pp r1, r3.x, r2, r1
mul r0, r0, c5
mul_pp r1, r0, r1
add r2.xyz, -v1, c1
dp3 r0.w, r2, r2
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r2.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r2, r2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c16.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
mul r2.x, r0, c9
rcp r2.y, r0.y
pow_sat r0, r2.x, c8.x
mul r0.y, r2, c14.x
add_sat r0.y, r0, -c13.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c15
mad r0.x, r0, r0.z, r0.y
mul_pp r0.w, r0.x, r1
dp4 r0.y, c3, c3
rsq r1.w, r0.y
mul r2.xyz, r1.w, c3
mov r0.x, c12
texldp r3.x, v6, s2
dp3_sat r2.x, v3, r2
mad r1.w, r3.x, c2.z, c2
add_pp r2.x, r2, c22.z
rcp r1.w, r1.w
mul_pp r2.x, r2, c4.w
add r1.w, r1, -v6.z
mul_sat r1.w, r1, c17.x
add r0.xyz, c4, r0.x
mul_pp_sat r2.x, r2, c22.w
mad_sat r0.xyz, r0, r2.x, c0
mul_pp oC0.w, r0, r1
mul_pp oC0.xyz, r1, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 288 // 276 used size, 18 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
Float 272 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
// 101 instructions, 4 temp regs, 0 temp arrays:
// ALU 90 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedakpagndpilhaekpngdfcafchmpdhmienabaaaaaaoiaoaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgianaaaa
eaaaaaaafkadaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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

#LINE 168

	
		}
		
	} 
	
}
}
