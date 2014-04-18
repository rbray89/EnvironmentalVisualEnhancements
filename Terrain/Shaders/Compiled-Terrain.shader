Shader "Sphere/Terrain" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Vector) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
	}

Category {
	
	Tags { "Queue"="Opaque" "RenderType"="Geometry" }
	Fog { Mode Global}
	ColorMask RGB
	Cull Back Lighting On ZWrite On
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 15
//   d3d9 - ALU: 20 to 20
//   d3d11 - ALU: 18 to 18, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedehhchkajoclbiooajfghaailppmiabggabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaalmaaaaaafmabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaf
bccabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaa
abaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 408
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
};
#line 400
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 395
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
#line 417
#line 438
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 425
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
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
#line 408
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
};
#line 400
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 395
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
#line 417
#line 438
#line 427
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 429
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 433
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 442
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 446
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 450
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 454
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 458
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 462
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_2).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcbobghahgahmjleeofidhcpelgfecebiabaaaaaadaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaeeabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaelaaaaafbccabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakoccabaaaabaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaacaaaaaa
agajbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 p_2;
  p_2 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 p_2;
  p_2 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 406
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 393
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 397
uniform highp float _MinLight;
#line 414
#line 435
#line 414
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 418
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 422
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
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
#line 406
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 393
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 397
uniform highp float _MinLight;
#line 414
#line 435
#line 424
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 426
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 430
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 435
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 439
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 443
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 447
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 451
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 455
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 459
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedigchbjgkjfegandbheoffedbkjicmmmgabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaalmaaaaaafmabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaf
bccabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaa
abaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 417
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
};
#line 409
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 404
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 408
uniform highp float _MinLight;
#line 426
#line 447
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 434
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
};
#line 409
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 404
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 408
uniform highp float _MinLight;
#line 426
#line 447
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 438
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 442
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 447
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 451
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 455
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 459
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 463
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 467
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 471
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedehhchkajoclbiooajfghaailppmiabggabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaalmaaaaaafmabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaf
bccabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaa
abaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 409
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
};
#line 401
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 396
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 400
uniform highp float _MinLight;
#line 418
#line 439
#line 418
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 422
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 426
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
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
#line 409
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
};
#line 401
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 396
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 400
uniform highp float _MinLight;
#line 418
#line 439
#line 428
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 430
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 434
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 443
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 447
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 451
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 455
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 459
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 463
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedifghhdgmhgejdpbgdlcepdcgdkeoaalnabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaalmaaaaaafmabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaf
bccabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaa
abaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec2 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec2 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 408
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec2 _LightCoord;
};
#line 400
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 395
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
#line 417
#line 438
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 425
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec2(xl_retval._LightCoord);
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
#line 408
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec2 _LightCoord;
};
#line 400
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 395
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
#line 417
#line 438
#line 427
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 429
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 433
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 442
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 446
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 450
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 454
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 458
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 462
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedndkopinjdplbjhoccndpbaeajjcgkaefabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 423
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 415
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 410
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 414
uniform highp float _MinLight;
#line 433
#line 454
#line 433
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 437
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 441
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 423
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 415
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 410
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 414
uniform highp float _MinLight;
#line 433
#line 454
#line 443
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 445
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 449
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 454
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 458
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 462
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 466
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 470
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 474
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 478
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedndkopinjdplbjhoccndpbaeajjcgkaefabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 424
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 416
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 411
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 415
uniform highp float _MinLight;
#line 434
#line 455
#line 434
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 438
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 442
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 424
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 416
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 411
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 415
uniform highp float _MinLight;
#line 434
#line 455
#line 444
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 446
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 450
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 455
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 459
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 463
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 467
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 471
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 475
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 479
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_3).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedigchbjgkjfegandbheoffedbkjicmmmgabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaalmaaaaaafmabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaf
bccabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaa
abaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec3 p_3;
  p_3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 414
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _ShadowCoord;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 401
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 405
uniform highp float _MinLight;
#line 423
#line 444
#line 423
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 427
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 431
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
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
#line 414
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _ShadowCoord;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 401
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 405
uniform highp float _MinLight;
#line 423
#line 444
#line 433
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 435
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 439
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 444
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 448
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 452
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 456
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 460
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 464
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 468
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec4 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcofgljonbpmgfgilfiabjliagmebeealabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 416
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 408
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 403
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 407
uniform highp float _MinLight;
#line 426
#line 447
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 434
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 416
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 408
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 403
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 407
uniform highp float _MinLight;
#line 426
#line 447
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 438
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 442
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 447
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 451
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 455
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 459
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 463
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 467
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 471
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeibchafgjaolfpmbnghhibgdaghbkcdbabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 421
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 413
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 408
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 412
uniform highp float _MinLight;
#line 431
#line 452
#line 431
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 435
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 439
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval._ShadowCoord);
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
#line 421
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 413
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 408
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 412
uniform highp float _MinLight;
#line 431
#line 452
#line 441
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 443
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 447
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 452
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 456
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 460
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 464
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 468
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 472
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 476
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeibchafgjaolfpmbnghhibgdaghbkcdbabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 422
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 414
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 409
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 413
uniform highp float _MinLight;
#line 432
#line 453
#line 432
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 436
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 440
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval._ShadowCoord);
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
#line 422
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 414
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 409
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 413
uniform highp float _MinLight;
#line 432
#line 453
#line 442
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 444
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 448
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 453
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 457
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 461
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 465
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 469
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 473
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 477
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedndkopinjdplbjhoccndpbaeajjcgkaefabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 431
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 418
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
#line 441
#line 462
#line 441
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 445
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 449
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 431
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 418
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
#line 441
#line 462
#line 451
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 453
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 457
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 462
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 466
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 470
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 474
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 478
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 482
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 486
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedndkopinjdplbjhoccndpbaeajjcgkaefabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 431
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 418
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
#line 441
#line 462
#line 441
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 445
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 449
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 431
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 418
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
#line 441
#line 462
#line 451
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 453
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 457
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 462
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 466
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 470
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 474
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 478
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 482
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 486
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeibchafgjaolfpmbnghhibgdaghbkcdbabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 427
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 414
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 418
uniform highp float _MinLight;
#line 437
#line 458
#line 437
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 441
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 445
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval._ShadowCoord);
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
#line 427
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 414
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 418
uniform highp float _MinLight;
#line 437
#line 458
#line 447
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 449
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 453
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 458
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 462
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 466
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 470
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 474
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 478
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 482
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
attribute vec3 TANGENT;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_4).xyz;
  xlv_TEXCOORD3 = -(normalize(TANGENT));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
uniform float _MinLight;
uniform float _DetailDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD3.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD3.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD3);
  color_2.w = 1.0;
  color_2.xyz = (((texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0)))).xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD2, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
mov r0.xyz, v1
mov r0.w, c9.x
dp4 o2.z, r0, c6
dp4 o2.y, r0, c5
dp4 o2.x, r0, c4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r0.yzw, -r0.xxyz, c8.xxyz
dp3 r0.y, r0.yzww, r0.yzww
dp3 r0.x, v2, v2
rsq r0.z, r0.x
rsq r0.x, r0.y
mul r0.yzw, r0.z, v2.xxyz
rcp o1.x, r0.x
mov o3.xyz, -r0.yzww
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "tangent" TexCoord2
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 19 instructions, 1 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeibchafgjaolfpmbnghhibgdaghbkcdbabaaaaaagaaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoabaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahapaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeacaaaaeaaaabaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaa
abaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbccabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakoccabaaaabaaaaaaagijcaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaagajbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD2 = (_Object2World * tmpvar_5).xyz;
  xlv_TEXCOORD3 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD3.z) > (1e-08 * abs(xlv_TEXCOORD3.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD3.x / xlv_TEXCOORD3.z);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD3.z < 0.0)) {
      if ((xlv_TEXCOORD3.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD3.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.y))) * (1.5708 + (abs(xlv_TEXCOORD3.y) * (-0.214602 + (abs(xlv_TEXCOORD3.y) * (0.0865667 + (abs(xlv_TEXCOORD3.y) * -0.0310296)))))))))));
  highp float r_17;
  if ((abs(xlv_TEXCOORD3.x) > (1e-08 * abs(xlv_TEXCOORD3.y)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD3.y / xlv_TEXCOORD3.x);
    highp float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD3.x < 0.0)) {
      if ((xlv_TEXCOORD3.y >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD3.y) * 1.5708);
  };
  highp float tmpvar_21;
  tmpvar_21 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD3.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD3.z))) * (1.5708 + (abs(xlv_TEXCOORD3.z) * (-0.214602 + (abs(xlv_TEXCOORD3.z) * (0.0865667 + (abs(xlv_TEXCOORD3.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_22;
  tmpvar_22 = dFdx(xlv_TEXCOORD3.xy);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdy(xlv_TEXCOORD3.xy);
  highp vec4 tmpvar_24;
  tmpvar_24.x = (0.159155 * sqrt(dot (tmpvar_22, tmpvar_22)));
  tmpvar_24.y = dFdx(tmpvar_21);
  tmpvar_24.z = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_24.w = dFdy(tmpvar_21);
  lowp vec4 tmpvar_25;
  tmpvar_25 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_24.xy, tmpvar_24.zw) * _Color);
  main_10 = tmpvar_25;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD3.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailX_9 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD3.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailY_8 = tmpvar_28;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((xlv_TEXCOORD3.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_30 = texture2D (_DetailTex, P_31);
  detailZ_7 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(xlv_TEXCOORD3);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (detailZ_7, detailX_9, tmpvar_32.xxxx);
  detail_6 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detail_6, detailY_8, tmpvar_32.yyyy);
  detail_6 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1), 0.0, 1.0);
  detailLevel_5 = tmpvar_35;
  color_12.w = 1.0;
  highp vec3 tmpvar_36;
  tmpvar_36 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_40;
  tmpvar_40 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_39)), 0.0, 1.0);
  color_12.xyz = ((main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5))).xyz * tmpvar_40);
  tmpvar_1 = color_12;
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
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 428
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 420
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 415
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 419
uniform highp float _MinLight;
#line 438
#line 459
#line 438
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 442
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = (_Object2World * vec4( v.normal, 0.0)).xyz;
    o.objNormal = (-normalize(v.tangent));
    #line 446
    return o;
}

out highp float xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD1 = float(xl_retval.viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval._ShadowCoord);
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
#line 428
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 420
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec3 tangent;
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
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
#line 415
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailDist;
#line 419
uniform highp float _MinLight;
#line 438
#line 459
#line 448
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 450
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 454
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 459
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 463
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    uv.y = (0.31831 * acos(objNrm.y));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 467
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 471
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 475
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = 1.0;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 479
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 483
    return color;
}
in highp float xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 91 to 91, TEX: 6 to 6
//   d3d11 - ALU: 65 to 65, TEX: 3 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedoijgfbhcjlnoeiabhmclagpflkbgnndgabaaaaaapaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiajaaaaeaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaa
abaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaia
ibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaa
fgbgbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaa
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
deaaaaahbcaabaaaabaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdodcaaaabajcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
dagojjlmaaaaaaaaaaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaa
chbgjidndcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaiedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaa
aaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdp
aaaaaaaaaaaaaaaakeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaa
kgaobaaaacaaaaaadcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejea
nlapejeaabaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaa
dcaaaaajdcaabaaaaaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaa
aaaaaaaadiaaaaakgcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaa
amaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaadaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaapcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
bacaaaahicaabaaaaaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaafgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4_pp r1.y, c1, c1
rsq_pp r1.y, r1.y
mul_pp r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 104 used size, 8 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 64 [_DetailScale]
Vector 80 [_DetailOffset] 4
Float 96 [_DetailDist]
Float 100 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfongfdainapemgiadbienpgjhboboljmabaaaaaaniakaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaheaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoiajaaaaeaaaaaaahkacaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadbcbabaaaabaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaa
aaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaia
ibaaaaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaia
ibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaa
fgbgbaaaacaaaaaafgbgbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaackbabaaaacaaaaaa
akbabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaackbabaaaacaaaaaaakbabaaa
acaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dhaaaaakbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoabeaaaaaaaaaaadpalaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaa
apaaaaahbcaabaaaaaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoamaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaa
apaaaaahbcaabaaaaaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdodcaaaabajcaabaaaaaaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaadagojjlmaaaaaaaaaaaaaaaadagojjlmaceaaaaachbgjidn
aaaaaaaaaaaaaaaachbgjidndcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaa
fgbjbaiaibaaaaaaacaaaaaaaceaaaaaiedefjloaaaaaaaaaaaaaaaaiedefjlo
dcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaa
aceaaaaakeanmjdpaaaaaaaaaaaaaaaakeanmjdpaaaaaaalmcaabaaaacaaaaaa
fgbjbaiambaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
elaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahmcaabaaaadaaaaaa
agambaaaaaaaaaaakgaobaaaacaaaaaadcaaaaapmcaabaaaadaaaaaakgaobaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaaamaaceaaaaaaaaaaaaa
aaaaaaaanlapejeanlapejeaabaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaa
kgalbaaaadaaaaaadcaaaaajdcaabaaaaaaaaaaamgaabaaaaaaaaaaaogakbaaa
acaaaaaajgafbaaaaaaaaaaadiaaaaakgcaabaaaabaaaaaaagabbaaaaaaaaaaa
aceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaacaaaaaa
ckaabaaaabaaaaaaamaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaejaaaaan
pcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaadaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaa
acaaaaaaagiacaaaaaaaaaaaaeaaaaaaegiecaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaa
aeaaaaaaegiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaakhcaabaaaacaaaaaa
agbabaiaibaaaaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaafgbfbaiaibaaaaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaapcaaaaiicaabaaaaaaaaaaaagbabaaa
abaaaaaaagiacaaaaaaaaaaaagaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaajgbhbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaadccaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlbpaofkicohgalkmkonfpbmegpbjcaboabaaaaaapaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiajaaaaeaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaa
abaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaia
ibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaa
fgbgbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaa
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
deaaaaahbcaabaaaabaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdodcaaaabajcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
dagojjlmaaaaaaaaaaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaa
chbgjidndcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaiedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaa
aaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdp
aaaaaaaaaaaaaaaakeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaa
kgaobaaaacaaaaaadcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejea
nlapejeaabaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaa
dcaaaaajdcaabaaaaaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaa
aaaaaaaadiaaaaakgcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaa
amaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaadaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaapcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
bacaaaahicaabaaaaaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaafgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedoijgfbhcjlnoeiabhmclagpflkbgnndgabaaaaaapaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiajaaaaeaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaa
abaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaia
ibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaa
fgbgbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaa
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
deaaaaahbcaabaaaabaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdodcaaaabajcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
dagojjlmaaaaaaaaaaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaa
chbgjidndcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaiedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaa
aaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdp
aaaaaaaaaaaaaaaakeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaa
kgaobaaaacaaaaaadcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejea
nlapejeaabaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaa
dcaaaaajdcaabaaaaaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaa
aaaaaaaadiaaaaakgcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaa
amaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaadaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaapcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
bacaaaahicaabaaaaaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaafgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4_pp r1.y, c1, c1
rsq_pp r1.y, r1.y
mul_pp r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedngnlegobamafegommmlcacpgkonpbickabaaaaaapaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaadaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiajaaaaeaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaa
abaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaia
ibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaa
fgbgbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaa
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
deaaaaahbcaabaaaabaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdodcaaaabajcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
dagojjlmaaaaaaaaaaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaa
chbgjidndcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaiedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaa
aaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdp
aaaaaaaaaaaaaaaakeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaa
kgaobaaaacaaaaaadcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejea
nlapejeaabaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaa
dcaaaaajdcaabaaaaaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaa
aaaaaaaadiaaaaakgcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaa
amaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaadaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaapcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
bacaaaahicaabaaaaaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaafgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcblblbhkfkmbajlmaklihibfoclobbkiabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
fgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcblblbhkfkmbajlmaklihibfoclobbkiabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
fgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4_pp r1.y, c1, c1
rsq_pp r1.y, r1.y
mul_pp r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlbpaofkicohgalkmkonfpbmegpbjcaboabaaaaaapaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiajaaaaeaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaa
abaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaia
ibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaa
fgbgbaiaebaaaaaaacaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaa
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
deaaaaahbcaabaaaabaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafjcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaamgaabaaaaaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdodcaaaabajcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
dagojjlmaaaaaaaaaaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaa
chbgjidndcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaiedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaa
aaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdp
aaaaaaaaaaaaaaaakeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaa
kgaobaaaacaaaaaadcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejea
nlapejeaabaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaa
dcaaaaajdcaabaaaaaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaa
aaaaaaaadiaaaaakgcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaa
amaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaadaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaapcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
bacaaaahicaabaaaaaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaafgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4_pp r1.y, c1, c1
rsq_pp r1.y, r1.y
mul_pp r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 232 used size, 10 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Float 192 [_DetailScale]
Vector 208 [_DetailOffset] 4
Float 224 [_DetailDist]
Float 228 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednglnkamojlbohkblakheapnbabaldfldabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaadaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egiecaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaaegiacaaaaaaaaaaaanaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedleogmlflemkfihncpekfnobmplinmmmjabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
fgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedleogmlflemkfihncpekfnobmplinmmmjabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
fgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 240 // 232 used size, 10 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Float 192 [_DetailScale]
Vector 208 [_DetailOffset] 4
Float 224 [_DetailDist]
Float 228 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddbjebegkkobnomdlbgghkapbadgdcjahabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egiecaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaaegiacaaaaaaaaaaaanaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 240 // 232 used size, 10 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Float 192 [_DetailScale]
Vector 208 [_DetailOffset] 4
Float 224 [_DetailDist]
Float 228 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddbjebegkkobnomdlbgghkapbadgdcjahabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egiecaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaaegiacaaaaaaaaaaaanaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedleogmlflemkfihncpekfnobmplinmmmjabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
fgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_DetailScale]
Vector 5 [_DetailOffset]
Float 6 [_DetailDist]
Float 7 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 91 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord1 v0.x
dcl_texcoord2 v1.xyz
dcl_texcoord3 v2.xyz
mul r1.xy, v2, c4.x
add r1.xy, r1, c5
dsy r3.xy, v2
abs r0.w, v2.z
abs r2.xy, v2
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mul r0.xy, v2.zyzw, c4.x
add r0.xy, r0, c5
mad r2.w, r2.z, c10.y, c10.z
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c10.w
mad r0.z, r0, r2, c11.x
mad r2.w, r0.z, r2.z, c11.y
mul r0.xy, v2.zxzw, c4.x
add r0.xy, r0, c5
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.z, r2.w, r2, c11
mul r2.y, r2.z, r1.w
add r1.w, r2.x, -r0
add r2.z, -r2.y, c11.w
mul r2.x, v0, c6
add_pp r1.xyz, -r0, c8.y
mul_sat r2.x, r2, c9.z
mad_pp r0.xyz, r2.x, r1, r0
cmp r1.w, -r1, r2.y, r2.z
add r1.x, -r1.w, c9.w
cmp r1.x, v2.z, r1.w, r1
cmp r1.x, v2, r1, -r1
mad r1.z, r1.x, c12.x, c12.y
mad r1.x, r0.w, c8.z, c8.w
dp4 r1.y, c1, c1
rsq r1.y, r1.y
mul r2.xyz, r1.y, c1
dp3_sat r3.z, v1, r2
abs r1.w, v2.y
add r1.y, -r0.w, c8
mad r1.x, r0.w, r1, c9
add r2.y, -r1.w, c8
mad r2.x, r1.w, c8.z, c8.w
mad r2.x, r2, r1.w, c9
rsq r1.y, r1.y
rsq r2.y, r2.y
dsx r2.zw, v2.xyxy
mad r0.w, r0, r1.x, c9.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v2.z, c8.x, c8.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c9.z, r1.x
mad r1.w, r2.x, r1, c9.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, v2.y, c8.x, c8.y
mul r2.y, r1.w, r2.x
mad r1.x, -r2.y, c9.z, r2
mad r1.y, r0.w, c9.w, r1
mad r0.w, r1, c9, r1.x
mul r1.x, r1.y, c10
mul r1.w, r0, c10.x
mul r2.zw, r2, r2
add r0.w, r2.z, r2
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c12
dsx r2.y, r1.x
dsy r1.y, r1.x
mul r3.xy, r3, r3
add r1.x, r3, r3.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c12
texldd r1.xyz, r1.zwzw, s0, r2, r1
add_pp r0.w, r3.z, c12.z
mul_pp r1.w, r0, c2
mul r1.xyz, r1, c3
mov r0.w, c7.x
mul_pp_sat r1.w, r1, c12
add r2.xyz, c2, r0.w
mad_sat r2.xyz, r2, r1.w, c0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, c8.y
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 176 // 168 used size, 9 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 128 [_DetailScale]
Vector 144 [_DetailOffset] 4
Float 160 [_DetailDist]
Float 164 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerFrame" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedleogmlflemkfihncpekfnobmplinmmmjabaaaaaaaialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiajaaaa
eaaaaaaahkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaad
ocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaa
akbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaa
ckbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaacaaaaaaakbabaiaibaaaaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaaigcaabaaaaaaaaaaafgbgbaaaacaaaaaafgbgbaiaebaaaaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaadbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaackbabaaaacaaaaaaakbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
jcaabaaaaaaaaaaaagbebaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaa
aaaaaaaamgaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaaba
jcaabaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
aaaaaaaadagojjlmaceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaan
jcaabaaaaaaaaaaaagambaaaaaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaaaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaa
aaaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaa
keanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaa
aaaaaaaamgaabaaaaaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaak
gcaabaaaabaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaackaabaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaakhcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaafgbfbaiaibaaaaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
apcaaaaiicaabaaaaaaaaaaaagbabaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaajgbhbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
fgifcaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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

#LINE 122

	
		}
		
	} 
	
}
}
