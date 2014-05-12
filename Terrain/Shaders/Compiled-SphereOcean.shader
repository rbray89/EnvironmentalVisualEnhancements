Shader "Sphere/Ocean" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_SpecColor ("Specular tint", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_Clarity ("Clarity", Range(0,1)) = .005
	}
	
SubShader {

Tags { "Queue"="Transparent-1" "IgnoreProjector"="True" "RenderType"="TransparentOcean" "OceanReplace"="True"}
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Back Lighting On ZWrite On
	
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 15
//   d3d9 - ALU: 33 to 42
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).w;
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
def c19, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c19.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c19.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c17.x
mov r0.x, r2
mad o6.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o5.xyz, -r0
mov o6.z, -r0.w
mov o6.w, r2
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_46;
  tmpvar_46 = texture2D (_LightTexture0, vec2(tmpvar_45)).w;
  mediump float tmpvar_47;
  tmpvar_47 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_46), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_47)), 0.0, 1.0);
  light_4 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  mediump vec3 i_51;
  i_51 = -(lightDirection_6);
  tmpvar_50 = (i_51 - (2.0 * (dot (normalDir_5, i_51) * normalDir_5)));
  highp vec3 tmpvar_52;
  tmpvar_52 = (specularReflection_3 * (((tmpvar_46 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_50, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (light_4 + (main_16.w * tmpvar_52));
  light_4 = tmpvar_53;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_54;
  tmpvar_54 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_55, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_56;
  tmpvar_1 = color_18;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_46;
  tmpvar_46 = texture2D (_LightTexture0, vec2(tmpvar_45)).w;
  mediump float tmpvar_47;
  tmpvar_47 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_46), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_47)), 0.0, 1.0);
  light_4 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  mediump vec3 i_51;
  i_51 = -(lightDirection_6);
  tmpvar_50 = (i_51 - (2.0 * (dot (normalDir_5, i_51) * normalDir_5)));
  highp vec3 tmpvar_52;
  tmpvar_52 = (specularReflection_3 * (((tmpvar_46 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_50, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (light_4 + (main_16.w * tmpvar_52));
  light_4 = tmpvar_53;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_54;
  tmpvar_54 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_55, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_56;
  tmpvar_1 = color_18;
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
#line 410
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 395
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 421
#line 447
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 421
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 425
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 429
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 434
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 410
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 395
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 421
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
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 447
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 451
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    #line 455
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    #line 459
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    #line 463
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 467
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    #line 471
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    #line 475
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    #line 479
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    #line 483
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    #line 487
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  vec3 i_19;
  i_19 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * ((_LightColor0.xyz * _SpecColor.xyz) * pow (clamp (dot ((i_19 - (2.0 * (dot (xlv_TEXCOORD2, i_19) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
"vs_3_0
; 33 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
def c15, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r1.w, v0, c7
mov r0.xyz, v1
mov r0.w, c15.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.z, r0.x
mul o3.xyz, r0.z, r1
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c15.y
dp4 r0.z, v0, c6
mov o0, r0
dp3 r0.y, v2, v2
dp4 r0.w, v0, c2
mov r1.x, r2
mul r1.y, r2, c13.x
mad o5.xy, r2.z, c14.zwzw, r1
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, -r1, c12
dp3 r2.x, r1, r1
rsq r0.x, r2.x
mul o2.xyz, r0.x, r1
rsq r0.y, r0.y
rcp o1.x, r0.x
mul r0.xyz, r0.y, v2
mov o4.xyz, -r0
mov o5.z, -r0.w
mov o5.w, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  light_4 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_47;
  mediump vec3 tmpvar_48;
  mediump vec3 i_49;
  i_49 = -(lightDirection_6);
  tmpvar_48 = (i_49 - (2.0 * (dot (normalDir_5, i_49) * normalDir_5)));
  highp vec3 tmpvar_50;
  tmpvar_50 = (specularReflection_3 * ((_LightColor0.xyz * _SpecColor.xyz) * pow (clamp (dot (tmpvar_48, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = (light_4 + (main_16.w * tmpvar_50));
  light_4 = tmpvar_51;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_52;
  tmpvar_52 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_53, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_54;
  tmpvar_1 = color_18;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  light_4 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_47;
  mediump vec3 tmpvar_48;
  mediump vec3 i_49;
  i_49 = -(lightDirection_6);
  tmpvar_48 = (i_49 - (2.0 * (dot (normalDir_5, i_49) * normalDir_5)));
  highp vec3 tmpvar_50;
  tmpvar_50 = (specularReflection_3 * ((_LightColor0.xyz * _SpecColor.xyz) * pow (clamp (dot (tmpvar_48, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = (light_4 + (main_16.w * tmpvar_50));
  light_4 = tmpvar_51;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_52;
  tmpvar_52 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_53, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_54;
  tmpvar_1 = color_18;
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
#line 408
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 401
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 397
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 418
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 418
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 422
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 426
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    #line 430
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 408
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 401
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 397
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 418
#line 443
#line 432
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 434
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 438
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 447
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    #line 451
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    #line 455
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    #line 459
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 463
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    #line 467
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = 1.0;
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    #line 471
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    #line 475
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    #line 479
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    #line 483
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w);
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
def c19, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c19.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c19.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c17.x
mov r0.x, r2
mad o6.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o5.xyz, -r0
mov o6.z, -r0.w
mov o6.w, r2
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_44;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_46 = texture2D (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  highp float tmpvar_50;
  tmpvar_50 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_46.w) * tmpvar_49.w);
  atten_5 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp ((((_LightColor0.w * ((tmpvar_45 - 0.01) / 0.99)) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_51)), 0.0, 1.0);
  light_4 = tmpvar_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = vec3(clamp (floor((1.0 + tmpvar_45)), 0.0, 1.0));
  specularReflection_3 = tmpvar_53;
  mediump vec3 tmpvar_54;
  mediump vec3 i_55;
  i_55 = -(lightDirection_7);
  tmpvar_54 = (i_55 - (2.0 * (dot (normalDir_6, i_55) * normalDir_6)));
  highp vec3 tmpvar_56;
  tmpvar_56 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_54, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (light_4 + (main_17.w * tmpvar_56));
  light_4 = tmpvar_57;
  color_19.xyz = (((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color).xyz * light_4);
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_59, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_60;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_44;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_46 = texture2D (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  highp float tmpvar_50;
  tmpvar_50 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_46.w) * tmpvar_49.w);
  atten_5 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp ((((_LightColor0.w * ((tmpvar_45 - 0.01) / 0.99)) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_51)), 0.0, 1.0);
  light_4 = tmpvar_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = vec3(clamp (floor((1.0 + tmpvar_45)), 0.0, 1.0));
  specularReflection_3 = tmpvar_53;
  mediump vec3 tmpvar_54;
  mediump vec3 i_55;
  i_55 = -(lightDirection_7);
  tmpvar_54 = (i_55 - (2.0 * (dot (normalDir_6, i_55) * normalDir_6)));
  highp vec3 tmpvar_56;
  tmpvar_56 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_54, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (light_4 + (main_17.w * tmpvar_56));
  light_4 = tmpvar_57;
  color_19.xyz = (((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color).xyz * light_4);
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_59, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_60;
  tmpvar_1 = color_19;
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
#line 419
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 412
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 404
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 408
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 430
#line 456
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 430
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 434
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 438
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 443
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 419
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 412
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 404
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 408
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 430
#line 456
#line 445
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 447
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 451
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 322
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 324
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 318
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 320
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 456
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 460
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    #line 464
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    #line 468
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    #line 472
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 476
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    #line 480
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    #line 484
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    #line 488
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    #line 492
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    #line 496
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
def c19, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c19.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c19.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c17.x
mov r0.x, r2
mad o6.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o5.xyz, -r0
mov o6.z, -r0.w
mov o6.w, r2
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_46;
  tmpvar_46 = (texture2D (_LightTextureB0, vec2(tmpvar_45)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  mediump float tmpvar_47;
  tmpvar_47 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_46), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_47)), 0.0, 1.0);
  light_4 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  mediump vec3 i_51;
  i_51 = -(lightDirection_6);
  tmpvar_50 = (i_51 - (2.0 * (dot (normalDir_5, i_51) * normalDir_5)));
  highp vec3 tmpvar_52;
  tmpvar_52 = (specularReflection_3 * (((tmpvar_46 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_50, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (light_4 + (main_16.w * tmpvar_52));
  light_4 = tmpvar_53;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_54;
  tmpvar_54 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_55, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_56;
  tmpvar_1 = color_18;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_46;
  tmpvar_46 = (texture2D (_LightTextureB0, vec2(tmpvar_45)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  mediump float tmpvar_47;
  tmpvar_47 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_46), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_47)), 0.0, 1.0);
  light_4 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  mediump vec3 i_51;
  i_51 = -(lightDirection_6);
  tmpvar_50 = (i_51 - (2.0 * (dot (normalDir_5, i_51) * normalDir_5)));
  highp vec3 tmpvar_52;
  tmpvar_52 = (specularReflection_3 * (((tmpvar_46 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_50, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (light_4 + (main_16.w * tmpvar_52));
  light_4 = tmpvar_53;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_54;
  tmpvar_54 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_55, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_56;
  tmpvar_1 = color_18;
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
#line 411
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 404
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 396
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 400
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 422
#line 448
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 422
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 426
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 430
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 435
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 411
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 404
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 396
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 400
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 422
#line 448
#line 437
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 439
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 443
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 452
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    #line 456
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    #line 460
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    #line 464
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 468
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    #line 472
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    #line 476
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    #line 480
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    #line 484
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    #line 488
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
def c19, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c19.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c19.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c17.x
mov r0.x, r2
mad o6.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o5.xyz, -r0
mov o6.z, -r0.w
mov o6.w, r2
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp float tmpvar_45;
  tmpvar_45 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  mediump float tmpvar_46;
  tmpvar_46 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_45), 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_46)), 0.0, 1.0);
  light_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_48;
  mediump vec3 tmpvar_49;
  mediump vec3 i_50;
  i_50 = -(lightDirection_6);
  tmpvar_49 = (i_50 - (2.0 * (dot (normalDir_5, i_50) * normalDir_5)));
  highp vec3 tmpvar_51;
  tmpvar_51 = (specularReflection_3 * (((tmpvar_45 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_49, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = (light_4 + (main_16.w * tmpvar_51));
  light_4 = tmpvar_52;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_53;
  tmpvar_53 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_54, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_55;
  tmpvar_1 = color_18;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp float tmpvar_45;
  tmpvar_45 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  mediump float tmpvar_46;
  tmpvar_46 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_45), 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_46)), 0.0, 1.0);
  light_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_48;
  mediump vec3 tmpvar_49;
  mediump vec3 i_50;
  i_50 = -(lightDirection_6);
  tmpvar_49 = (i_50 - (2.0 * (dot (normalDir_5, i_50) * normalDir_5)));
  highp vec3 tmpvar_51;
  tmpvar_51 = (specularReflection_3 * (((tmpvar_45 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_49, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = (light_4 + (main_16.w * tmpvar_51));
  light_4 = tmpvar_52;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_53;
  tmpvar_53 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_54, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_55;
  tmpvar_1 = color_18;
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
#line 410
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 395
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 421
#line 447
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 421
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 425
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 429
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 434
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 410
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 395
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 399
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 421
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
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 447
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 451
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    #line 455
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    #line 459
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    #line 463
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 467
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    #line 471
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, IN._LightCoord).w * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    #line 475
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    #line 479
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    #line 483
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    #line 487
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = ((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color);
  color_2 = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0);
  float tmpvar_19;
  tmpvar_19 = clamp (dot (xlv_TEXCOORD2, tmpvar_18.xyz), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 - 0.01) / 0.99);
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
  vec4 tmpvar_23;
  tmpvar_23 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  float tmpvar_24;
  if ((tmpvar_23.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_24 = _LightShadowData.x;
  } else {
    tmpvar_24 = 1.0;
  };
  float tmpvar_25;
  tmpvar_25 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_21.w) * tmpvar_22.w) * tmpvar_24);
  vec3 i_26;
  i_26 = -(tmpvar_18.xyz);
  color_2.xyz = (tmpvar_17.xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_20) * 4.0) * tmpvar_25), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_19)), 0.0, 1.0)) * (((tmpvar_25 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_26 - (2.0 * (dot (xlv_TEXCOORD2, i_26) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
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
def c23, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c23.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c14
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c23.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c21.x
mov r0.x, r2
mad o7.xy, r2.z, c22.zwzw, r0
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
add r2.xyz, -r0, c20
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c15
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c11
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_48 = texture2D (_LightTexture0, P_49);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_LightTextureB0, vec2(tmpvar_50));
  lowp float tmpvar_52;
  mediump float shadow_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  highp float tmpvar_55;
  if ((tmpvar_54.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_55 = _LightShadowData.x;
  } else {
    tmpvar_55 = 1.0;
  };
  shadow_53 = tmpvar_55;
  tmpvar_52 = shadow_53;
  highp float tmpvar_56;
  tmpvar_56 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w) * tmpvar_52);
  atten_5 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_4 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_7);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_6, i_61) * normalDir_6)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_4 + (main_17.w * tmpvar_62));
  light_4 = tmpvar_63;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_64;
  tmpvar_64 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_65, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_66;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_48 = texture2D (_LightTexture0, P_49);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_LightTextureB0, vec2(tmpvar_50));
  lowp float tmpvar_52;
  mediump float shadow_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  highp float tmpvar_55;
  if ((tmpvar_54.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_55 = _LightShadowData.x;
  } else {
    tmpvar_55 = 1.0;
  };
  shadow_53 = tmpvar_55;
  tmpvar_52 = shadow_53;
  highp float tmpvar_56;
  tmpvar_56 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w) * tmpvar_52);
  atten_5 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_4 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_7);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_6, i_61) * normalDir_6)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_4 + (main_17.w * tmpvar_62));
  light_4 = tmpvar_63;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_64;
  tmpvar_64 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_65, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_66;
  tmpvar_1 = color_19;
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
#line 425
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 418
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 410
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 414
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 437
#line 453
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 437
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 441
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 445
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 449
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 425
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 418
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 410
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 414
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 437
#line 453
#line 453
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 457
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
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
#line 328
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 324
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 316
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = (( (textureProj( _ShadowMapTexture, shadowCoord).x < (shadowCoord.z / shadowCoord.w)) ) ? ( _LightShadowData.x ) : ( 1.0 ));
    #line 319
    return shadow;
}
#line 464
lowp vec4 frag( in v2f IN ) {
    #line 466
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 470
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 474
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 478
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 482
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 486
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 490
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 494
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 498
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 502
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = (((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w) * (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x * (1.0 - _LightShadowData.x))));
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
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
def c23, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c23.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c14
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c23.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c21.x
mov r0.x, r2
mad o7.xy, r2.z, c22.zwzw, r0
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
add r2.xyz, -r0, c20
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c15
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c11
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_44;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_46 = texture2D (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  lowp float tmpvar_50;
  mediump float shadow_51;
  lowp float tmpvar_52;
  tmpvar_52 = shadow2DProjEXT (_ShadowMapTexture, xlv_TEXCOORD4);
  shadow_51 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = (_LightShadowData.x + (shadow_51 * (1.0 - _LightShadowData.x)));
  shadow_51 = tmpvar_53;
  tmpvar_50 = shadow_51;
  highp float tmpvar_54;
  tmpvar_54 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_46.w) * tmpvar_49.w) * tmpvar_50);
  atten_5 = tmpvar_54;
  mediump float tmpvar_55;
  tmpvar_55 = clamp ((((_LightColor0.w * ((tmpvar_45 - 0.01) / 0.99)) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_56;
  tmpvar_56 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_55)), 0.0, 1.0);
  light_4 = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57 = vec3(clamp (floor((1.0 + tmpvar_45)), 0.0, 1.0));
  specularReflection_3 = tmpvar_57;
  mediump vec3 tmpvar_58;
  mediump vec3 i_59;
  i_59 = -(lightDirection_7);
  tmpvar_58 = (i_59 - (2.0 * (dot (normalDir_6, i_59) * normalDir_6)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_58, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_60;
  highp vec3 tmpvar_61;
  tmpvar_61 = (light_4 + (main_17.w * tmpvar_60));
  light_4 = tmpvar_61;
  color_19.xyz = (((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color).xyz * light_4);
  lowp float tmpvar_62;
  tmpvar_62 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_63, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_64;
  tmpvar_1 = color_19;
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
#line 426
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 411
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 415
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 438
#line 454
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 438
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 442
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 446
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 450
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
float xll_shadow2Dproj(mediump sampler2DShadow s, vec4 coord) { return textureProj (s, coord); }
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
#line 426
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 411
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 415
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 438
#line 454
#line 454
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 458
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 462
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 329
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 331
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 325
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 327
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 316
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = xll_shadow2Dproj( _ShadowMapTexture, shadowCoord);
    #line 319
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 465
lowp vec4 frag( in v2f IN ) {
    #line 467
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 471
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 475
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 479
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 483
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 487
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 491
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 495
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 499
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 503
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_2 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19.x), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19.x * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
def c15, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r0.xyz, v1
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp3 r0.x, r2, r2
rsq r0.z, r0.x
mul o3.xyz, r0.z, r2
mov r0.w, r2
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c15.y
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mad r1.xy, r1.z, c14.zwzw, r1
mov r1.zw, r0
dp3 r0.y, v2, v2
dp4 r0.w, v0, c2
mov o4, r1
dp4 r2.z, v0, c10
dp4 r2.x, v0, c8
dp4 r2.y, v0, c9
add r2.xyz, -r2, c12
mov o6.xy, r1
dp3 r1.x, r2, r2
rsq r0.x, r1.x
mul o2.xyz, r0.x, r2
rsq r0.y, r0.y
rcp o1.x, r0.x
mul r0.xyz, r0.y, v2
mov o5.xyz, -r0
mov o6.z, -r0.w
mov o6.w, r2
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp float tmpvar_45;
  mediump float lightShadowDataX_46;
  highp float dist_47;
  lowp float tmpvar_48;
  tmpvar_48 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = _LightShadowData.x;
  lightShadowDataX_46 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = max (float((dist_47 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_46);
  tmpvar_45 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_45), 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_51)), 0.0, 1.0);
  light_4 = tmpvar_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_53;
  mediump vec3 tmpvar_54;
  mediump vec3 i_55;
  i_55 = -(lightDirection_6);
  tmpvar_54 = (i_55 - (2.0 * (dot (normalDir_5, i_55) * normalDir_5)));
  highp vec3 tmpvar_56;
  tmpvar_56 = (specularReflection_3 * (((tmpvar_45 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_54, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (light_4 + (main_16.w * tmpvar_56));
  light_4 = tmpvar_57;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_59, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_60;
  tmpvar_1 = color_18;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  mediump float tmpvar_46;
  tmpvar_46 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_45.x), 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_46)), 0.0, 1.0);
  light_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_48;
  mediump vec3 tmpvar_49;
  mediump vec3 i_50;
  i_50 = -(lightDirection_6);
  tmpvar_49 = (i_50 - (2.0 * (dot (normalDir_5, i_50) * normalDir_5)));
  highp vec3 tmpvar_51;
  tmpvar_51 = (specularReflection_3 * (((tmpvar_45.x * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_49, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = (light_4 + (main_16.w * tmpvar_51));
  light_4 = tmpvar_52;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_53;
  tmpvar_53 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_54, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_55;
  tmpvar_1 = color_18;
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
#line 416
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 409
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 401
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 405
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 427
#line 453
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 427
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 431
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 435
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 440
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 416
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 409
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 401
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 405
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 427
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
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 453
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 457
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    #line 461
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    #line 465
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    #line 469
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 473
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    #line 477
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    #line 481
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    #line 485
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    #line 489
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    #line 493
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_2 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD4 = o_8;
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x);
  vec3 i_20;
  i_20 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_19), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_19 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_20 - (2.0 * (dot (xlv_TEXCOORD2, i_20) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c19, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r0.xyz, v1
mov r0.w, c19.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r1.w, r2
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c19.y
mul r0.y, r0, c17.x
mad r3.xy, r0.z, c18.zwzw, r0
mov o0, r1
mov r3.zw, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mul o3.xyz, r0.w, r2
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mov o5, r3
mov o7.xy, r3
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp float tmpvar_45;
  mediump float lightShadowDataX_46;
  highp float dist_47;
  lowp float tmpvar_48;
  tmpvar_48 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = _LightShadowData.x;
  lightShadowDataX_46 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = max (float((dist_47 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_46);
  tmpvar_45 = tmpvar_50;
  lowp float tmpvar_51;
  tmpvar_51 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * tmpvar_45);
  mediump float tmpvar_52;
  tmpvar_52 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_51), 0.0, 1.0);
  highp vec3 tmpvar_53;
  tmpvar_53 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_52)), 0.0, 1.0);
  light_4 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_54;
  mediump vec3 tmpvar_55;
  mediump vec3 i_56;
  i_56 = -(lightDirection_6);
  tmpvar_55 = (i_56 - (2.0 * (dot (normalDir_5, i_56) * normalDir_5)));
  highp vec3 tmpvar_57;
  tmpvar_57 = (specularReflection_3 * (((tmpvar_51 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_55, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (light_4 + (main_16.w * tmpvar_57));
  light_4 = tmpvar_58;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_59;
  tmpvar_59 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_60, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_61;
  tmpvar_1 = color_18;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD4 = o_9;
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 detail_9;
  mediump vec4 detailZ_10;
  mediump vec4 detailY_11;
  mediump vec4 detailX_12;
  mediump vec2 detailnrmxy_13;
  mediump vec2 detailnrmzx_14;
  mediump vec2 detailnrmzy_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  mediump vec4 color_18;
  highp float r_19;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_20;
    y_over_x_20 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_21;
    highp float x_22;
    x_22 = (y_over_x_20 * inversesqrt(((y_over_x_20 * y_over_x_20) + 1.0)));
    s_21 = (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))));
    r_19 = s_21;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_19 = (s_21 + 3.14159);
      } else {
        r_19 = (r_19 - 3.14159);
      };
    };
  } else {
    r_19 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_19));
  uv_17.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw);
  main_16 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_15 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_14 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_13 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_DetailTex, detailnrmzy_15);
  detailX_12 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzx_14);
  detailY_11 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmxy_13);
  detailZ_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (detailZ_10, detailX_12, tmpvar_38.xxxx);
  detail_9 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detail_9, detailY_11, tmpvar_38.yyyy);
  detail_9 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_43;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp float tmpvar_45;
  tmpvar_45 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x);
  mediump float tmpvar_46;
  tmpvar_46 = clamp ((((_LightColor0.w * ((tmpvar_44 - 0.01) / 0.99)) * 4.0) * tmpvar_45), 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_46)), 0.0, 1.0);
  light_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = vec3(clamp (floor((1.0 + tmpvar_44)), 0.0, 1.0));
  specularReflection_3 = tmpvar_48;
  mediump vec3 tmpvar_49;
  mediump vec3 i_50;
  i_50 = -(lightDirection_6);
  tmpvar_49 = (i_50 - (2.0 * (dot (normalDir_5, i_50) * normalDir_5)));
  highp vec3 tmpvar_51;
  tmpvar_51 = (specularReflection_3 * (((tmpvar_45 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_49, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = (light_4 + (main_16.w * tmpvar_51));
  light_4 = tmpvar_52;
  color_18.xyz = (((main_16 * mix (detail_9, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8))) * _Color).xyz * light_4);
  lowp float tmpvar_53;
  tmpvar_53 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_54, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_18.w = tmpvar_55;
  tmpvar_1 = color_18;
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
#line 418
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 411
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 403
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 407
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 430
#line 446
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 430
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 434
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 438
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 442
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 418
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 411
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 403
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 407
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 430
#line 446
#line 446
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 450
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 454
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    #line 459
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 463
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 467
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 471
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 475
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 479
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 483
    lowp float atten = (texture( _LightTexture0, IN._LightCoord).w * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 487
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 491
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 495
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = ((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color);
  color_2 = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0);
  float tmpvar_19;
  tmpvar_19 = clamp (dot (xlv_TEXCOORD2, tmpvar_18.xyz), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 - 0.01) / 0.99);
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  float tmpvar_23;
  tmpvar_23 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD4), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  float tmpvar_24;
  if ((tmpvar_23 < tmpvar_22)) {
    tmpvar_24 = _LightShadowData.x;
  } else {
    tmpvar_24 = 1.0;
  };
  float tmpvar_25;
  tmpvar_25 = (tmpvar_21.w * tmpvar_24);
  vec3 i_26;
  i_26 = -(tmpvar_18.xyz);
  color_2.xyz = (tmpvar_17.xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_20) * 4.0) * tmpvar_25), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_19)), 0.0, 1.0)) * (((tmpvar_25 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_26 - (2.0 * (dot (xlv_TEXCOORD2, i_26) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c20.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
mov r1.w, r2
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c20.y
dp4 r1.z, v0, c6
mul r0.y, r2, c17.x
mov r0.x, r2
mad o7.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
mov o0, r1
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r0.w, v2, v2
rsq r0.w, r0.w
add o5.xyz, r0, -c19
mul r0.xyz, r0.w, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTexture0, vec2(tmpvar_48));
  highp float tmpvar_50;
  tmpvar_50 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_51 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (packDist_51, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_54;
  if ((tmpvar_53 < tmpvar_50)) {
    tmpvar_54 = _LightShadowData.x;
  } else {
    tmpvar_54 = 1.0;
  };
  highp float tmpvar_55;
  tmpvar_55 = (tmpvar_49.w * tmpvar_54);
  atten_5 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_56)), 0.0, 1.0);
  light_4 = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_58;
  mediump vec3 tmpvar_59;
  mediump vec3 i_60;
  i_60 = -(lightDirection_7);
  tmpvar_59 = (i_60 - (2.0 * (dot (normalDir_6, i_60) * normalDir_6)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_59, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_61;
  highp vec3 tmpvar_62;
  tmpvar_62 = (light_4 + (main_17.w * tmpvar_61));
  light_4 = tmpvar_62;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_63;
  tmpvar_63 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_64, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_65;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTexture0, vec2(tmpvar_48));
  highp float tmpvar_50;
  tmpvar_50 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_51 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (packDist_51, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_54;
  if ((tmpvar_53 < tmpvar_50)) {
    tmpvar_54 = _LightShadowData.x;
  } else {
    tmpvar_54 = 1.0;
  };
  highp float tmpvar_55;
  tmpvar_55 = (tmpvar_49.w * tmpvar_54);
  atten_5 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_56)), 0.0, 1.0);
  light_4 = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_58;
  mediump vec3 tmpvar_59;
  mediump vec3 i_60;
  i_60 = -(lightDirection_7);
  tmpvar_59 = (i_60 - (2.0 * (dot (normalDir_6, i_60) * normalDir_6)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_59, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_61;
  highp vec3 tmpvar_62;
  tmpvar_62 = (light_4 + (main_17.w * tmpvar_61));
  light_4 = tmpvar_62;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_63;
  tmpvar_63 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_64, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_65;
  tmpvar_1 = color_19;
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
#line 423
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 416
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 408
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 412
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 435
#line 451
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 435
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 439
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 443
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 447
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 423
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 416
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 408
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 412
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 435
#line 451
#line 451
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 455
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 459
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 462
lowp vec4 frag( in v2f IN ) {
    #line 464
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 468
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 472
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 476
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 480
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 484
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 488
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 492
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 496
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 500
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = ((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color);
  color_2 = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0);
  float tmpvar_19;
  tmpvar_19 = clamp (dot (xlv_TEXCOORD2, tmpvar_18.xyz), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 - 0.01) / 0.99);
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 tmpvar_22;
  tmpvar_22 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  float tmpvar_23;
  tmpvar_23 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  float tmpvar_24;
  tmpvar_24 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD4), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  float tmpvar_25;
  if ((tmpvar_24 < tmpvar_23)) {
    tmpvar_25 = _LightShadowData.x;
  } else {
    tmpvar_25 = 1.0;
  };
  float tmpvar_26;
  tmpvar_26 = ((tmpvar_21.w * tmpvar_22.w) * tmpvar_25);
  vec3 i_27;
  i_27 = -(tmpvar_18.xyz);
  color_2.xyz = (tmpvar_17.xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_20) * 4.0) * tmpvar_26), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_19)), 0.0, 1.0)) * (((tmpvar_26 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_27 - (2.0 * (dot (xlv_TEXCOORD2, i_27) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c20.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
mov r1.w, r2
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c20.y
dp4 r1.z, v0, c6
mul r0.y, r2, c17.x
mov r0.x, r2
mad o7.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
mov o0, r1
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r0.w, v2, v2
rsq r0.w, r0.w
add o5.xyz, r0, -c19
mul r0.xyz, r0.w, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  lowp vec4 tmpvar_50;
  tmpvar_50 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_51;
  tmpvar_51 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_52 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (packDist_52, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_55;
  if ((tmpvar_54 < tmpvar_51)) {
    tmpvar_55 = _LightShadowData.x;
  } else {
    tmpvar_55 = 1.0;
  };
  highp float tmpvar_56;
  tmpvar_56 = ((tmpvar_49.w * tmpvar_50.w) * tmpvar_55);
  atten_5 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_4 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_7);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_6, i_61) * normalDir_6)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_4 + (main_17.w * tmpvar_62));
  light_4 = tmpvar_63;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_64;
  tmpvar_64 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_65, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_66;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  lowp vec4 tmpvar_50;
  tmpvar_50 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_51;
  tmpvar_51 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_52 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (packDist_52, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_55;
  if ((tmpvar_54 < tmpvar_51)) {
    tmpvar_55 = _LightShadowData.x;
  } else {
    tmpvar_55 = 1.0;
  };
  highp float tmpvar_56;
  tmpvar_56 = ((tmpvar_49.w * tmpvar_50.w) * tmpvar_55);
  atten_5 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_4 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_7);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_6, i_61) * normalDir_6)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_4 + (main_17.w * tmpvar_62));
  light_4 = tmpvar_63;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_64;
  tmpvar_64 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_65, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_66;
  tmpvar_1 = color_19;
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
#line 424
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 417
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 409
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 413
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 436
#line 452
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 436
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 440
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 444
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 448
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
#line 424
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 417
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 409
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 413
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 436
#line 452
#line 452
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 456
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 460
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 463
lowp vec4 frag( in v2f IN ) {
    #line 465
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 469
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 473
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 477
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 481
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 485
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 489
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 493
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 497
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 501
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = ((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color);
  color_2 = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0);
  float tmpvar_19;
  tmpvar_19 = clamp (dot (xlv_TEXCOORD2, tmpvar_18.xyz), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 - 0.01) / 0.99);
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
  vec4 shadowVals_23;
  vec3 tmpvar_24;
  tmpvar_24 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  shadowVals_23.x = texture2D (_ShadowMapTexture, (tmpvar_24.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_23.y = texture2D (_ShadowMapTexture, (tmpvar_24.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_23.z = texture2D (_ShadowMapTexture, (tmpvar_24.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_23.w = texture2D (_ShadowMapTexture, (tmpvar_24.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_25;
  tmpvar_25 = lessThan (shadowVals_23, tmpvar_24.zzzz);
  vec4 tmpvar_26;
  tmpvar_26 = _LightShadowData.xxxx;
  float tmpvar_27;
  if (tmpvar_25.x) {
    tmpvar_27 = tmpvar_26.x;
  } else {
    tmpvar_27 = 1.0;
  };
  float tmpvar_28;
  if (tmpvar_25.y) {
    tmpvar_28 = tmpvar_26.y;
  } else {
    tmpvar_28 = 1.0;
  };
  float tmpvar_29;
  if (tmpvar_25.z) {
    tmpvar_29 = tmpvar_26.z;
  } else {
    tmpvar_29 = 1.0;
  };
  float tmpvar_30;
  if (tmpvar_25.w) {
    tmpvar_30 = tmpvar_26.w;
  } else {
    tmpvar_30 = 1.0;
  };
  vec4 tmpvar_31;
  tmpvar_31.x = tmpvar_27;
  tmpvar_31.y = tmpvar_28;
  tmpvar_31.z = tmpvar_29;
  tmpvar_31.w = tmpvar_30;
  float tmpvar_32;
  tmpvar_32 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_21.w) * tmpvar_22.w) * dot (tmpvar_31, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_33;
  i_33 = -(tmpvar_18.xyz);
  color_2.xyz = (tmpvar_17.xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_20) * 4.0) * tmpvar_32), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_19)), 0.0, 1.0)) * (((tmpvar_32 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_33 - (2.0 * (dot (xlv_TEXCOORD2, i_33) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
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
def c23, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c23.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c14
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c23.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c21.x
mov r0.x, r2
mad o7.xy, r2.z, c22.zwzw, r0
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
add r2.xyz, -r0, c20
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c15
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c11
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_48 = texture2D (_LightTexture0, P_49);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_LightTextureB0, vec2(tmpvar_50));
  lowp float tmpvar_52;
  mediump vec4 shadows_53;
  highp vec4 shadowVals_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec2 P_56;
  P_56 = (tmpvar_55.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_57;
  tmpvar_57 = texture2D (_ShadowMapTexture, P_56).x;
  shadowVals_54.x = tmpvar_57;
  highp vec2 P_58;
  P_58 = (tmpvar_55.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_59;
  tmpvar_59 = texture2D (_ShadowMapTexture, P_58).x;
  shadowVals_54.y = tmpvar_59;
  highp vec2 P_60;
  P_60 = (tmpvar_55.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_61;
  tmpvar_61 = texture2D (_ShadowMapTexture, P_60).x;
  shadowVals_54.z = tmpvar_61;
  highp vec2 P_62;
  P_62 = (tmpvar_55.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_63;
  tmpvar_63 = texture2D (_ShadowMapTexture, P_62).x;
  shadowVals_54.w = tmpvar_63;
  bvec4 tmpvar_64;
  tmpvar_64 = lessThan (shadowVals_54, tmpvar_55.zzzz);
  highp vec4 tmpvar_65;
  tmpvar_65 = _LightShadowData.xxxx;
  highp float tmpvar_66;
  if (tmpvar_64.x) {
    tmpvar_66 = tmpvar_65.x;
  } else {
    tmpvar_66 = 1.0;
  };
  highp float tmpvar_67;
  if (tmpvar_64.y) {
    tmpvar_67 = tmpvar_65.y;
  } else {
    tmpvar_67 = 1.0;
  };
  highp float tmpvar_68;
  if (tmpvar_64.z) {
    tmpvar_68 = tmpvar_65.z;
  } else {
    tmpvar_68 = 1.0;
  };
  highp float tmpvar_69;
  if (tmpvar_64.w) {
    tmpvar_69 = tmpvar_65.w;
  } else {
    tmpvar_69 = 1.0;
  };
  highp vec4 tmpvar_70;
  tmpvar_70.x = tmpvar_66;
  tmpvar_70.y = tmpvar_67;
  tmpvar_70.z = tmpvar_68;
  tmpvar_70.w = tmpvar_69;
  shadows_53 = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (shadows_53, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_52 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w) * tmpvar_52);
  atten_5 = tmpvar_72;
  mediump float tmpvar_73;
  tmpvar_73 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_74;
  tmpvar_74 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_73)), 0.0, 1.0);
  light_4 = tmpvar_74;
  mediump vec3 tmpvar_75;
  tmpvar_75 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_75;
  mediump vec3 tmpvar_76;
  mediump vec3 i_77;
  i_77 = -(lightDirection_7);
  tmpvar_76 = (i_77 - (2.0 * (dot (normalDir_6, i_77) * normalDir_6)));
  highp vec3 tmpvar_78;
  tmpvar_78 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_76, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_78;
  highp vec3 tmpvar_79;
  tmpvar_79 = (light_4 + (main_17.w * tmpvar_78));
  light_4 = tmpvar_79;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_80;
  tmpvar_80 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_81, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_82;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_48 = texture2D (_LightTexture0, P_49);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_LightTextureB0, vec2(tmpvar_50));
  lowp float tmpvar_52;
  mediump vec4 shadows_53;
  highp vec4 shadowVals_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec2 P_56;
  P_56 = (tmpvar_55.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_57;
  tmpvar_57 = texture2D (_ShadowMapTexture, P_56).x;
  shadowVals_54.x = tmpvar_57;
  highp vec2 P_58;
  P_58 = (tmpvar_55.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_59;
  tmpvar_59 = texture2D (_ShadowMapTexture, P_58).x;
  shadowVals_54.y = tmpvar_59;
  highp vec2 P_60;
  P_60 = (tmpvar_55.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_61;
  tmpvar_61 = texture2D (_ShadowMapTexture, P_60).x;
  shadowVals_54.z = tmpvar_61;
  highp vec2 P_62;
  P_62 = (tmpvar_55.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_63;
  tmpvar_63 = texture2D (_ShadowMapTexture, P_62).x;
  shadowVals_54.w = tmpvar_63;
  bvec4 tmpvar_64;
  tmpvar_64 = lessThan (shadowVals_54, tmpvar_55.zzzz);
  highp vec4 tmpvar_65;
  tmpvar_65 = _LightShadowData.xxxx;
  highp float tmpvar_66;
  if (tmpvar_64.x) {
    tmpvar_66 = tmpvar_65.x;
  } else {
    tmpvar_66 = 1.0;
  };
  highp float tmpvar_67;
  if (tmpvar_64.y) {
    tmpvar_67 = tmpvar_65.y;
  } else {
    tmpvar_67 = 1.0;
  };
  highp float tmpvar_68;
  if (tmpvar_64.z) {
    tmpvar_68 = tmpvar_65.z;
  } else {
    tmpvar_68 = 1.0;
  };
  highp float tmpvar_69;
  if (tmpvar_64.w) {
    tmpvar_69 = tmpvar_65.w;
  } else {
    tmpvar_69 = 1.0;
  };
  highp vec4 tmpvar_70;
  tmpvar_70.x = tmpvar_66;
  tmpvar_70.y = tmpvar_67;
  tmpvar_70.z = tmpvar_68;
  tmpvar_70.w = tmpvar_69;
  shadows_53 = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (shadows_53, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_52 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w) * tmpvar_52);
  atten_5 = tmpvar_72;
  mediump float tmpvar_73;
  tmpvar_73 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_74;
  tmpvar_74 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_73)), 0.0, 1.0);
  light_4 = tmpvar_74;
  mediump vec3 tmpvar_75;
  tmpvar_75 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_75;
  mediump vec3 tmpvar_76;
  mediump vec3 i_77;
  i_77 = -(lightDirection_7);
  tmpvar_76 = (i_77 - (2.0 * (dot (normalDir_6, i_77) * normalDir_6)));
  highp vec3 tmpvar_78;
  tmpvar_78 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_76, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_78;
  highp vec3 tmpvar_79;
  tmpvar_79 = (light_4 + (main_17.w * tmpvar_78));
  light_4 = tmpvar_79;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_80;
  tmpvar_80 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_81, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_82;
  tmpvar_1 = color_19;
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
#line 433
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 426
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 418
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 445
#line 461
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 445
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 449
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 453
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 457
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 433
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 426
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 418
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 445
#line 461
#line 461
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 465
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 469
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 336
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 332
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    highp vec4 shadowVals;
    shadowVals.x = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[0].xy)).x;
    shadowVals.y = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[1].xy)).x;
    #line 323
    shadowVals.z = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[2].xy)).x;
    shadowVals.w = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[3].xy)).x;
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, coord.zzzz), vec4( _LightShadowData.xxxx), vec4( 1.0));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 327
    return shadow;
}
#line 472
lowp vec4 frag( in v2f IN ) {
    #line 474
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 478
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 482
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 486
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 490
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 494
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 498
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 502
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 506
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 510
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _ShadowOffsets[4];
uniform sampler2DShadow _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0);
  float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, tmpvar_17.xyz), 0.0, 1.0);
  vec4 shadows_19;
  vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  shadows_19.x = shadow2D (_ShadowMapTexture, (tmpvar_20 + _ShadowOffsets[0].xyz)).x;
  shadows_19.y = shadow2D (_ShadowMapTexture, (tmpvar_20 + _ShadowOffsets[1].xyz)).x;
  shadows_19.z = shadow2D (_ShadowMapTexture, (tmpvar_20 + _ShadowOffsets[2].xyz)).x;
  shadows_19.w = shadow2D (_ShadowMapTexture, (tmpvar_20 + _ShadowOffsets[3].xyz)).x;
  vec4 tmpvar_21;
  tmpvar_21 = (_LightShadowData.xxxx + (shadows_19 * (1.0 - _LightShadowData.xxxx)));
  shadows_19 = tmpvar_21;
  float tmpvar_22;
  tmpvar_22 = (((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w) * dot (tmpvar_21, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_23;
  i_23 = -(tmpvar_17.xyz);
  color_2.xyz = (((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color).xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_18 - 0.01) / 0.99)) * 4.0) * tmpvar_22), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_18)), 0.0, 1.0)) * (((tmpvar_22 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_23 - (2.0 * (dot (xlv_TEXCOORD2, i_23) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_ProjectionParams]
Vector 22 [_ScreenParams]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
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
def c23, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c23.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c14
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, r2
mul r2.xyz, r1.xyww, c23.y
dp4 r1.z, v0, c6
mov o0, r1
mul r0.y, r2, c21.x
mov r0.x, r2
mad o7.xy, r2.z, c22.zwzw, r0
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
add r2.xyz, -r0, c20
dp3 r0.w, r2, r2
rsq r1.x, r0.w
dp4 r0.w, v0, c15
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c11
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
dp3 r1.y, v2, v2
rsq r0.x, r1.y
mul r0.xyz, r0.x, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_44;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_46 = texture2D (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  lowp float tmpvar_50;
  mediump vec4 shadows_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec3 coord_53;
  coord_53 = (tmpvar_52 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_54;
  tmpvar_54 = shadow2DEXT (_ShadowMapTexture, coord_53);
  shadows_51.x = tmpvar_54;
  highp vec3 coord_55;
  coord_55 = (tmpvar_52 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_56;
  tmpvar_56 = shadow2DEXT (_ShadowMapTexture, coord_55);
  shadows_51.y = tmpvar_56;
  highp vec3 coord_57;
  coord_57 = (tmpvar_52 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_58;
  tmpvar_58 = shadow2DEXT (_ShadowMapTexture, coord_57);
  shadows_51.z = tmpvar_58;
  highp vec3 coord_59;
  coord_59 = (tmpvar_52 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_60;
  tmpvar_60 = shadow2DEXT (_ShadowMapTexture, coord_59);
  shadows_51.w = tmpvar_60;
  highp vec4 tmpvar_61;
  tmpvar_61 = (_LightShadowData.xxxx + (shadows_51 * (1.0 - _LightShadowData.xxxx)));
  shadows_51 = tmpvar_61;
  mediump float tmpvar_62;
  tmpvar_62 = dot (shadows_51, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_50 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_46.w) * tmpvar_49.w) * tmpvar_50);
  atten_5 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = clamp ((((_LightColor0.w * ((tmpvar_45 - 0.01) / 0.99)) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_65;
  tmpvar_65 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_64)), 0.0, 1.0);
  light_4 = tmpvar_65;
  mediump vec3 tmpvar_66;
  tmpvar_66 = vec3(clamp (floor((1.0 + tmpvar_45)), 0.0, 1.0));
  specularReflection_3 = tmpvar_66;
  mediump vec3 tmpvar_67;
  mediump vec3 i_68;
  i_68 = -(lightDirection_7);
  tmpvar_67 = (i_68 - (2.0 * (dot (normalDir_6, i_68) * normalDir_6)));
  highp vec3 tmpvar_69;
  tmpvar_69 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_67, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = (light_4 + (main_17.w * tmpvar_69));
  light_4 = tmpvar_70;
  color_19.xyz = (((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color).xyz * light_4);
  lowp float tmpvar_71;
  tmpvar_71 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_72, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_73;
  tmpvar_1 = color_19;
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
#line 433
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 426
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 418
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 445
#line 461
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 445
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 449
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 453
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 457
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
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
#line 433
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 426
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 418
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 422
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 445
#line 461
#line 461
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 465
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 469
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 336
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 332
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    mediump vec4 shadows;
    shadows.x = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[0])).xyz);
    shadows.y = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[1])).xyz);
    #line 323
    shadows.z = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[2])).xyz);
    shadows.w = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[3])).xyz);
    shadows = (_LightShadowData.xxxx + (shadows * (1.0 - _LightShadowData.xxxx)));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 327
    return shadow;
}
#line 472
lowp vec4 frag( in v2f IN ) {
    #line 474
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 478
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 482
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 486
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 490
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 494
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 498
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 502
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 506
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 510
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = ((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color);
  color_2 = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0);
  float tmpvar_19;
  tmpvar_19 = clamp (dot (xlv_TEXCOORD2, tmpvar_18.xyz), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 - 0.01) / 0.99);
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 shadowVals_22;
  shadowVals_22.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_22.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_22.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_22.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_23;
  tmpvar_23 = lessThan (shadowVals_22, vec4(((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_24;
  tmpvar_24 = _LightShadowData.xxxx;
  float tmpvar_25;
  if (tmpvar_23.x) {
    tmpvar_25 = tmpvar_24.x;
  } else {
    tmpvar_25 = 1.0;
  };
  float tmpvar_26;
  if (tmpvar_23.y) {
    tmpvar_26 = tmpvar_24.y;
  } else {
    tmpvar_26 = 1.0;
  };
  float tmpvar_27;
  if (tmpvar_23.z) {
    tmpvar_27 = tmpvar_24.z;
  } else {
    tmpvar_27 = 1.0;
  };
  float tmpvar_28;
  if (tmpvar_23.w) {
    tmpvar_28 = tmpvar_24.w;
  } else {
    tmpvar_28 = 1.0;
  };
  vec4 tmpvar_29;
  tmpvar_29.x = tmpvar_25;
  tmpvar_29.y = tmpvar_26;
  tmpvar_29.z = tmpvar_27;
  tmpvar_29.w = tmpvar_28;
  float tmpvar_30;
  tmpvar_30 = (tmpvar_21.w * dot (tmpvar_29, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_31;
  i_31 = -(tmpvar_18.xyz);
  color_2.xyz = (tmpvar_17.xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_20) * 4.0) * tmpvar_30), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_19)), 0.0, 1.0)) * (((tmpvar_30 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_31 - (2.0 * (dot (xlv_TEXCOORD2, i_31) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c20.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
mov r1.w, r2
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c20.y
dp4 r1.z, v0, c6
mul r0.y, r2, c17.x
mov r0.x, r2
mad o7.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
mov o0, r1
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r0.w, v2, v2
rsq r0.w, r0.w
add o5.xyz, r0, -c19
mul r0.xyz, r0.w, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTexture0, vec2(tmpvar_48));
  highp float tmpvar_50;
  mediump vec4 shadows_51;
  highp vec4 shadowVals_52;
  highp float tmpvar_53;
  tmpvar_53 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_54;
  vec_54 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_55;
  lowp vec4 tmpvar_56;
  tmpvar_56 = textureCube (_ShadowMapTexture, vec_54);
  packDist_55 = tmpvar_56;
  shadowVals_52.x = dot (packDist_55, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_57;
  vec_57 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_58;
  lowp vec4 tmpvar_59;
  tmpvar_59 = textureCube (_ShadowMapTexture, vec_57);
  packDist_58 = tmpvar_59;
  shadowVals_52.y = dot (packDist_58, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_60;
  vec_60 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = textureCube (_ShadowMapTexture, vec_60);
  packDist_61 = tmpvar_62;
  shadowVals_52.z = dot (packDist_61, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_63;
  vec_63 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_64;
  lowp vec4 tmpvar_65;
  tmpvar_65 = textureCube (_ShadowMapTexture, vec_63);
  packDist_64 = tmpvar_65;
  shadowVals_52.w = dot (packDist_64, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_66;
  tmpvar_66 = lessThan (shadowVals_52, vec4(tmpvar_53));
  highp vec4 tmpvar_67;
  tmpvar_67 = _LightShadowData.xxxx;
  highp float tmpvar_68;
  if (tmpvar_66.x) {
    tmpvar_68 = tmpvar_67.x;
  } else {
    tmpvar_68 = 1.0;
  };
  highp float tmpvar_69;
  if (tmpvar_66.y) {
    tmpvar_69 = tmpvar_67.y;
  } else {
    tmpvar_69 = 1.0;
  };
  highp float tmpvar_70;
  if (tmpvar_66.z) {
    tmpvar_70 = tmpvar_67.z;
  } else {
    tmpvar_70 = 1.0;
  };
  highp float tmpvar_71;
  if (tmpvar_66.w) {
    tmpvar_71 = tmpvar_67.w;
  } else {
    tmpvar_71 = 1.0;
  };
  highp vec4 tmpvar_72;
  tmpvar_72.x = tmpvar_68;
  tmpvar_72.y = tmpvar_69;
  tmpvar_72.z = tmpvar_70;
  tmpvar_72.w = tmpvar_71;
  shadows_51 = tmpvar_72;
  mediump float tmpvar_73;
  tmpvar_73 = dot (shadows_51, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_50 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = (tmpvar_49.w * tmpvar_50);
  atten_5 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_76;
  tmpvar_76 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_75)), 0.0, 1.0);
  light_4 = tmpvar_76;
  mediump vec3 tmpvar_77;
  tmpvar_77 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_77;
  mediump vec3 tmpvar_78;
  mediump vec3 i_79;
  i_79 = -(lightDirection_7);
  tmpvar_78 = (i_79 - (2.0 * (dot (normalDir_6, i_79) * normalDir_6)));
  highp vec3 tmpvar_80;
  tmpvar_80 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_78, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = (light_4 + (main_17.w * tmpvar_80));
  light_4 = tmpvar_81;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_82;
  tmpvar_82 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_83, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_84;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTexture0, vec2(tmpvar_48));
  highp float tmpvar_50;
  mediump vec4 shadows_51;
  highp vec4 shadowVals_52;
  highp float tmpvar_53;
  tmpvar_53 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_54;
  vec_54 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_55;
  lowp vec4 tmpvar_56;
  tmpvar_56 = textureCube (_ShadowMapTexture, vec_54);
  packDist_55 = tmpvar_56;
  shadowVals_52.x = dot (packDist_55, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_57;
  vec_57 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_58;
  lowp vec4 tmpvar_59;
  tmpvar_59 = textureCube (_ShadowMapTexture, vec_57);
  packDist_58 = tmpvar_59;
  shadowVals_52.y = dot (packDist_58, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_60;
  vec_60 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = textureCube (_ShadowMapTexture, vec_60);
  packDist_61 = tmpvar_62;
  shadowVals_52.z = dot (packDist_61, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_63;
  vec_63 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_64;
  lowp vec4 tmpvar_65;
  tmpvar_65 = textureCube (_ShadowMapTexture, vec_63);
  packDist_64 = tmpvar_65;
  shadowVals_52.w = dot (packDist_64, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_66;
  tmpvar_66 = lessThan (shadowVals_52, vec4(tmpvar_53));
  highp vec4 tmpvar_67;
  tmpvar_67 = _LightShadowData.xxxx;
  highp float tmpvar_68;
  if (tmpvar_66.x) {
    tmpvar_68 = tmpvar_67.x;
  } else {
    tmpvar_68 = 1.0;
  };
  highp float tmpvar_69;
  if (tmpvar_66.y) {
    tmpvar_69 = tmpvar_67.y;
  } else {
    tmpvar_69 = 1.0;
  };
  highp float tmpvar_70;
  if (tmpvar_66.z) {
    tmpvar_70 = tmpvar_67.z;
  } else {
    tmpvar_70 = 1.0;
  };
  highp float tmpvar_71;
  if (tmpvar_66.w) {
    tmpvar_71 = tmpvar_67.w;
  } else {
    tmpvar_71 = 1.0;
  };
  highp vec4 tmpvar_72;
  tmpvar_72.x = tmpvar_68;
  tmpvar_72.y = tmpvar_69;
  tmpvar_72.z = tmpvar_70;
  tmpvar_72.w = tmpvar_71;
  shadows_51 = tmpvar_72;
  mediump float tmpvar_73;
  tmpvar_73 = dot (shadows_51, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_50 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = (tmpvar_49.w * tmpvar_50);
  atten_5 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_76;
  tmpvar_76 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_75)), 0.0, 1.0);
  light_4 = tmpvar_76;
  mediump vec3 tmpvar_77;
  tmpvar_77 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_77;
  mediump vec3 tmpvar_78;
  mediump vec3 i_79;
  i_79 = -(lightDirection_7);
  tmpvar_78 = (i_79 - (2.0 * (dot (normalDir_6, i_79) * normalDir_6)));
  highp vec3 tmpvar_80;
  tmpvar_80 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_78, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = (light_4 + (main_17.w * tmpvar_80));
  light_4 = tmpvar_81;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_82;
  tmpvar_82 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_83, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_84;
  tmpvar_1 = color_19;
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
#line 429
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 422
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 414
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 418
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 441
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 441
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 445
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 449
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 453
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 429
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 422
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 414
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 418
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 441
#line 457
#line 457
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 461
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 465
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    #line 327
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    #line 331
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 468
lowp vec4 frag( in v2f IN ) {
    #line 470
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 474
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 478
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 482
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 486
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 490
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 494
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 498
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 502
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 506
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
attribute vec3 TANGENT;
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
  vec3 p_3;
  p_3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_5.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(TANGENT));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform float _Clarity;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;

uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD5.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD5.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec4 tmpvar_15;
  tmpvar_15 = texture2DGradARB (_MainTex, uv_1, tmpvar_14.xy, tmpvar_14.zw);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD5);
  vec4 tmpvar_17;
  tmpvar_17 = ((tmpvar_15 * mix (mix (mix (texture2D (_DetailTex, (xlv_TEXCOORD5.xy * _DetailScale)), texture2D (_DetailTex, (xlv_TEXCOORD5.zy * _DetailScale)), tmpvar_16.xxxx), texture2D (_DetailTex, (xlv_TEXCOORD5.zx * _DetailScale)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0)))) * _Color);
  color_2 = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0);
  float tmpvar_19;
  tmpvar_19 = clamp (dot (xlv_TEXCOORD2, tmpvar_18.xyz), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 - 0.01) / 0.99);
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 tmpvar_22;
  tmpvar_22 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  vec4 shadowVals_23;
  shadowVals_23.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_23.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_23.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_23.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_24;
  tmpvar_24 = lessThan (shadowVals_23, vec4(((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_25;
  tmpvar_25 = _LightShadowData.xxxx;
  float tmpvar_26;
  if (tmpvar_24.x) {
    tmpvar_26 = tmpvar_25.x;
  } else {
    tmpvar_26 = 1.0;
  };
  float tmpvar_27;
  if (tmpvar_24.y) {
    tmpvar_27 = tmpvar_25.y;
  } else {
    tmpvar_27 = 1.0;
  };
  float tmpvar_28;
  if (tmpvar_24.z) {
    tmpvar_28 = tmpvar_25.z;
  } else {
    tmpvar_28 = 1.0;
  };
  float tmpvar_29;
  if (tmpvar_24.w) {
    tmpvar_29 = tmpvar_25.w;
  } else {
    tmpvar_29 = 1.0;
  };
  vec4 tmpvar_30;
  tmpvar_30.x = tmpvar_26;
  tmpvar_30.y = tmpvar_27;
  tmpvar_30.z = tmpvar_28;
  tmpvar_30.w = tmpvar_29;
  float tmpvar_31;
  tmpvar_31 = ((tmpvar_21.w * tmpvar_22.w) * dot (tmpvar_30, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_32;
  i_32 = -(tmpvar_18.xyz);
  color_2.xyz = (tmpvar_17.xyz * (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_20) * 4.0) * tmpvar_31), 0.0, 1.0))), 0.0, 1.0) + (tmpvar_15.w * (vec3(clamp (floor((1.0 + tmpvar_19)), 0.0, 1.0)) * (((tmpvar_31 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_32 - (2.0 * (dot (xlv_TEXCOORD2, i_32) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess))))));
  color_2.w = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0), clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
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
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_tangent0 v2
dp4 r2.w, v0, c7
mov r1.xyz, v1
mov r1.w, c20.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r1.x, v0, c4
mov r1.w, r2
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c20.y
dp4 r1.z, v0, c6
mul r0.y, r2, c17.x
mov r0.x, r2
mad o7.xy, r2.z, c18.zwzw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c16
dp3 r0.w, r2, r2
mov o0, r1
rsq r1.x, r0.w
dp4 r0.w, v0, c11
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp3 r0.w, v2, v2
rsq r0.w, r0.w
add o5.xyz, r0, -c19
mul r0.xyz, r0.w, v2
dp4 r0.w, v0, c2
mul o2.xyz, r1.x, r2
rcp o1.x, r1.x
mov o6.xyz, -r0
mov o7.z, -r0.w
mov o7.w, r2
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  lowp vec4 tmpvar_50;
  tmpvar_50 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_51;
  mediump vec4 shadows_52;
  highp vec4 shadowVals_53;
  highp float tmpvar_54;
  tmpvar_54 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_55;
  vec_55 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_56;
  lowp vec4 tmpvar_57;
  tmpvar_57 = textureCube (_ShadowMapTexture, vec_55);
  packDist_56 = tmpvar_57;
  shadowVals_53.x = dot (packDist_56, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_58;
  vec_58 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_59;
  lowp vec4 tmpvar_60;
  tmpvar_60 = textureCube (_ShadowMapTexture, vec_58);
  packDist_59 = tmpvar_60;
  shadowVals_53.y = dot (packDist_59, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_61;
  vec_61 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = textureCube (_ShadowMapTexture, vec_61);
  packDist_62 = tmpvar_63;
  shadowVals_53.z = dot (packDist_62, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_64;
  vec_64 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_65;
  lowp vec4 tmpvar_66;
  tmpvar_66 = textureCube (_ShadowMapTexture, vec_64);
  packDist_65 = tmpvar_66;
  shadowVals_53.w = dot (packDist_65, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_67;
  tmpvar_67 = lessThan (shadowVals_53, vec4(tmpvar_54));
  highp vec4 tmpvar_68;
  tmpvar_68 = _LightShadowData.xxxx;
  highp float tmpvar_69;
  if (tmpvar_67.x) {
    tmpvar_69 = tmpvar_68.x;
  } else {
    tmpvar_69 = 1.0;
  };
  highp float tmpvar_70;
  if (tmpvar_67.y) {
    tmpvar_70 = tmpvar_68.y;
  } else {
    tmpvar_70 = 1.0;
  };
  highp float tmpvar_71;
  if (tmpvar_67.z) {
    tmpvar_71 = tmpvar_68.z;
  } else {
    tmpvar_71 = 1.0;
  };
  highp float tmpvar_72;
  if (tmpvar_67.w) {
    tmpvar_72 = tmpvar_68.w;
  } else {
    tmpvar_72 = 1.0;
  };
  highp vec4 tmpvar_73;
  tmpvar_73.x = tmpvar_69;
  tmpvar_73.y = tmpvar_70;
  tmpvar_73.z = tmpvar_71;
  tmpvar_73.w = tmpvar_72;
  shadows_52 = tmpvar_73;
  mediump float tmpvar_74;
  tmpvar_74 = dot (shadows_52, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_51 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = ((tmpvar_49.w * tmpvar_50.w) * tmpvar_51);
  atten_5 = tmpvar_75;
  mediump float tmpvar_76;
  tmpvar_76 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_77;
  tmpvar_77 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_76)), 0.0, 1.0);
  light_4 = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_78;
  mediump vec3 tmpvar_79;
  mediump vec3 i_80;
  i_80 = -(lightDirection_7);
  tmpvar_79 = (i_80 - (2.0 * (dot (normalDir_6, i_80) * normalDir_6)));
  highp vec3 tmpvar_81;
  tmpvar_81 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_79, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_81;
  highp vec3 tmpvar_82;
  tmpvar_82 = (light_4 + (main_17.w * tmpvar_81));
  light_4 = tmpvar_82;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_83;
  tmpvar_83 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_84, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_85;
  tmpvar_1 = color_19;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ProjectionParams;
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
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_4;
  p_4 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesNormal);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_6.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_5).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_1.xyz));
  xlv_TEXCOORD6 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform sampler2D _CameraDepthTexture;
uniform highp float _Clarity;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 specularReflection_3;
  mediump vec3 light_4;
  lowp float atten_5;
  mediump vec3 normalDir_6;
  mediump vec3 lightDirection_7;
  mediump vec3 ambientLighting_8;
  mediump float detailLevel_9;
  mediump vec4 detail_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec2 detailnrmxy_14;
  mediump vec2 detailnrmzx_15;
  mediump vec2 detailnrmzy_16;
  mediump vec4 main_17;
  highp vec2 uv_18;
  mediump vec4 color_19;
  highp float r_20;
  if ((abs(xlv_TEXCOORD5.z) > (1e-08 * abs(xlv_TEXCOORD5.x)))) {
    highp float y_over_x_21;
    y_over_x_21 = (xlv_TEXCOORD5.x / xlv_TEXCOORD5.z);
    float s_22;
    highp float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((xlv_TEXCOORD5.z < 0.0)) {
      if ((xlv_TEXCOORD5.x >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(xlv_TEXCOORD5.x) * 1.5708);
  };
  uv_18.x = (0.5 + (0.159155 * r_20));
  uv_18.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.y))) * (1.5708 + (abs(xlv_TEXCOORD5.y) * (-0.214602 + (abs(xlv_TEXCOORD5.y) * (0.0865667 + (abs(xlv_TEXCOORD5.y) * -0.0310296)))))))))));
  highp float r_24;
  if ((abs(xlv_TEXCOORD5.x) > (1e-08 * abs(xlv_TEXCOORD5.y)))) {
    highp float y_over_x_25;
    y_over_x_25 = (xlv_TEXCOORD5.y / xlv_TEXCOORD5.x);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((xlv_TEXCOORD5.x < 0.0)) {
      if ((xlv_TEXCOORD5.y >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(xlv_TEXCOORD5.y) * 1.5708);
  };
  highp float tmpvar_28;
  tmpvar_28 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD5.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD5.z))) * (1.5708 + (abs(xlv_TEXCOORD5.z) * (-0.214602 + (abs(xlv_TEXCOORD5.z) * (0.0865667 + (abs(xlv_TEXCOORD5.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD5.xy);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD5.xy);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DGradEXT (_MainTex, uv_18, tmpvar_31.xy, tmpvar_31.zw);
  main_17 = tmpvar_32;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD5.zy * _DetailScale);
  detailnrmzy_16 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = (xlv_TEXCOORD5.zx * _DetailScale);
  detailnrmzx_15 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD5.xy * _DetailScale);
  detailnrmxy_14 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DetailTex, detailnrmzy_16);
  detailX_13 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DetailTex, detailnrmzx_15);
  detailY_12 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_DetailTex, detailnrmxy_14);
  detailZ_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = abs(xlv_TEXCOORD5);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (detailZ_11, detailX_13, tmpvar_39.xxxx);
  detail_10 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = mix (detail_10, detailY_12, tmpvar_39.yyyy);
  detail_10 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_9 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = ((main_17 * mix (detail_10, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_9))) * _Color);
  color_19 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_8 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_7 = tmpvar_45;
  normalDir_6 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_6, lightDirection_7), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 - 0.01) / 0.99);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_LightTextureB0, vec2(tmpvar_48));
  lowp vec4 tmpvar_50;
  tmpvar_50 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_51;
  mediump vec4 shadows_52;
  highp vec4 shadowVals_53;
  highp float tmpvar_54;
  tmpvar_54 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_55;
  vec_55 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_56;
  lowp vec4 tmpvar_57;
  tmpvar_57 = textureCube (_ShadowMapTexture, vec_55);
  packDist_56 = tmpvar_57;
  shadowVals_53.x = dot (packDist_56, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_58;
  vec_58 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_59;
  lowp vec4 tmpvar_60;
  tmpvar_60 = textureCube (_ShadowMapTexture, vec_58);
  packDist_59 = tmpvar_60;
  shadowVals_53.y = dot (packDist_59, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_61;
  vec_61 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = textureCube (_ShadowMapTexture, vec_61);
  packDist_62 = tmpvar_63;
  shadowVals_53.z = dot (packDist_62, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_64;
  vec_64 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_65;
  lowp vec4 tmpvar_66;
  tmpvar_66 = textureCube (_ShadowMapTexture, vec_64);
  packDist_65 = tmpvar_66;
  shadowVals_53.w = dot (packDist_65, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_67;
  tmpvar_67 = lessThan (shadowVals_53, vec4(tmpvar_54));
  highp vec4 tmpvar_68;
  tmpvar_68 = _LightShadowData.xxxx;
  highp float tmpvar_69;
  if (tmpvar_67.x) {
    tmpvar_69 = tmpvar_68.x;
  } else {
    tmpvar_69 = 1.0;
  };
  highp float tmpvar_70;
  if (tmpvar_67.y) {
    tmpvar_70 = tmpvar_68.y;
  } else {
    tmpvar_70 = 1.0;
  };
  highp float tmpvar_71;
  if (tmpvar_67.z) {
    tmpvar_71 = tmpvar_68.z;
  } else {
    tmpvar_71 = 1.0;
  };
  highp float tmpvar_72;
  if (tmpvar_67.w) {
    tmpvar_72 = tmpvar_68.w;
  } else {
    tmpvar_72 = 1.0;
  };
  highp vec4 tmpvar_73;
  tmpvar_73.x = tmpvar_69;
  tmpvar_73.y = tmpvar_70;
  tmpvar_73.z = tmpvar_71;
  tmpvar_73.w = tmpvar_72;
  shadows_52 = tmpvar_73;
  mediump float tmpvar_74;
  tmpvar_74 = dot (shadows_52, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_51 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = ((tmpvar_49.w * tmpvar_50.w) * tmpvar_51);
  atten_5 = tmpvar_75;
  mediump float tmpvar_76;
  tmpvar_76 = clamp ((((_LightColor0.w * tmpvar_47) * 4.0) * atten_5), 0.0, 1.0);
  highp vec3 tmpvar_77;
  tmpvar_77 = clamp ((ambientLighting_8 + ((_MinLight + _LightColor0.xyz) * tmpvar_76)), 0.0, 1.0);
  light_4 = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_3 = tmpvar_78;
  mediump vec3 tmpvar_79;
  mediump vec3 i_80;
  i_80 = -(lightDirection_7);
  tmpvar_79 = (i_80 - (2.0 * (dot (normalDir_6, i_80) * normalDir_6)));
  highp vec3 tmpvar_81;
  tmpvar_81 = (specularReflection_3 * (((atten_5 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_79, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_3 = tmpvar_81;
  highp vec3 tmpvar_82;
  tmpvar_82 = (light_4 + (main_17.w * tmpvar_81));
  light_4 = tmpvar_82;
  color_19.xyz = (tmpvar_43.xyz * light_4);
  lowp float tmpvar_83;
  tmpvar_83 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6).x;
  depth_2 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp ((_Clarity * ((1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w))) - xlv_TEXCOORD6.z)), 0.0, 1.0);
  depth_2 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = mix ((1.0 - (0.75 * dot (xlv_TEXCOORD1, xlv_TEXCOORD2))), tmpvar_84, clamp ((0.002 * (xlv_TEXCOORD0 - 600.0)), 0.0, 1.0));
  color_19.w = tmpvar_85;
  tmpvar_1 = color_19;
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
#line 430
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 415
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 419
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 442
#line 458
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 446
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    o.sphereNormal = (-normalize(v.tangent));
    #line 450
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * v.vertex).xyz));
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 454
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec3(TANGENT);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
    xlv_TEXCOORD6 = vec4(xl_retval.scrPos);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 430
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
    highp vec4 scrPos;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
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
uniform highp float _Shininess;
#line 415
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 419
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
uniform highp mat4 _CameraToWorld;
#line 442
#line 458
#line 458
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 462
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 466
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    #line 327
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    #line 331
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 469
lowp vec4 frag( in v2f IN ) {
    #line 471
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereNrm.x, sphereNrm.z)));
    #line 475
    uv.y = (0.31831 * acos(sphereNrm.y));
    highp vec4 uvdd = Derivatives( sphereNrm);
    mediump vec4 main = xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw);
    mediump vec2 detailnrmzy = (sphereNrm.zy * _DetailScale);
    #line 479
    mediump vec2 detailnrmzx = (sphereNrm.zx * _DetailScale);
    mediump vec2 detailnrmxy = (sphereNrm.xy * _DetailScale);
    mediump vec4 detailX = texture( _DetailTex, detailnrmzy);
    mediump vec4 detailY = texture( _DetailTex, detailnrmzx);
    #line 483
    mediump vec4 detailZ = texture( _DetailTex, detailnrmxy);
    sphereNrm = abs(sphereNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( sphereNrm.x));
    detail = mix( detail, detailY, vec4( sphereNrm.y));
    #line 487
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 491
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 495
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    #line 499
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.xyz *= light;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    #line 503
    highp float satDepth = xll_saturate_f((0.002 * (IN.viewDist - 600.0)));
    depth = LinearEyeDepth( depth);
    depth -= IN.scrPos.z;
    depth = xll_saturate_f((_Clarity * depth));
    #line 507
    highp float refrac = (1.0 - (0.75 * dot( IN.viewDir, IN.worldNormal)));
    color.w = mix( refrac, depth, satDepth);
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD4);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 115 to 135, TEX: 7 to 13
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 117 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord5 v4.xyz
dcl_texcoord6 v5
mul r0.xy, v4, c7.x
mul r1.xy, v4.zyzw, c7.x
mul r2.z, v0.x, c8.x
dsx r4.xy, v4
dsy r4.zw, v4.xyxy
abs r0.w, v4.z
abs r3.xy, v4
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r0.w
rcp r1.w, r0.z
min r0.z, r3.x, r0.w
mul r1.w, r0.z, r1
mul r2.x, r1.w, r1.w
mad r2.y, r2.x, c14, c14.z
mad r2.y, r2, r2.x, c14.w
mul r0.xy, v4.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c11.w
mul_sat r2.z, r2, c13
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c15.x
mad r0.x, r2.y, r2, c15.y
dp4 r0.y, c2, c2
mad r0.x, r0, r2, c15.z
rsq r0.z, r0.y
mul r0.y, r0.x, r1.w
mul r2.xyz, r0.z, c2
add r0.x, r3, -r0.w
add r0.z, -r0.y, c15.w
dp3_pp r2.w, v2, -r2
cmp r1.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c13.z, -r2
dp3_pp_sat r0.y, v1, r0
pow_pp r3, r0.y, c6.x
add r2.w, -r1, c13
cmp r1.w, v4.z, r1, r2
cmp r0.x, v4, r1.w, -r1.w
mad r3.z, r0.x, c16.x, c16.y
add r0.y, -r0.w, c11.w
mad r0.x, r0.w, c12.z, c12.w
mad r0.x, r0.w, r0, c13
mad r0.x, r0.w, r0, c13.y
abs r0.w, v4.y
add r2.w, -r0, c11
mad r1.w, r0, c12.z, c12
mad r1.w, r1, r0, c13.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v4.z, c12, c12.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c13, r0.y
rsq r2.w, r2.w
mad r0.w, r1, r0, c13.y
rcp r2.w, r2.w
mul r1.w, r0, r2
cmp r0.w, v4.y, c12.x, c12.y
mul r2.w, r0, r1
mad r0.y, -r2.w, c13.z, r1.w
mad r0.z, r0.x, c13.w, r0
mad r0.x, r0.w, c13.w, r0.y
mul r0.y, r0.z, c14.x
mul r3.w, r0.x, c14.x
dsx r0.w, r0.y
mul r4.xy, r4, r4
mul r4.zw, r4, r4
add r0.x, r4, r4.y
add r0.z, r4, r4.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r1.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.w, c16
dsy r0.y, r0
texldd r0, r3.zwzw, s0, r0.zwzw, r0
mul_pp r1.xyz, r0, r1
dp3_pp_sat r0.y, v2, r2
add_pp r0.z, r0.y, c11.w
dp3 r0.x, v3, v3
texld r0.x, r0.x, s2
mul r2.xyz, r0.x, c3
frc_pp r1.w, r0.z
add_pp r0.y, r0, c16.z
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
add_pp_sat r0.z, r0, -r1.w
mov_pp r2.w, r3.x
mul r2.xyz, r2, c4
mul r2.xyz, r2, r2.w
mul r2.xyz, r0.z, r2
mul r2.xyz, r0.w, r2
mul_pp_sat r0.w, r0.y, c16
mov r0.x, c9
add r0.xyz, c3, r0.x
mad_sat r0.xyz, r0, r0.w, c0
add_pp r2.xyz, r0, r2
mul_pp r0.xyz, r1, c5
mul_pp oC0.xyz, r0, r2
texldp r0.x, v5, s3
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v5.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
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

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_CameraDepthTexture] 2D
"ps_3_0
; 115 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord5 v3.xyz
dcl_texcoord6 v4
mul r0.xy, v3, c7.x
mul r1.xy, v3.zyzw, c7.x
abs r0.w, v3.z
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r2.xyz, r1, -r0
abs r1.xy, v3
mad_pp r2.xyz, r1.x, r2, r0
max r1.z, r1.x, r0.w
min r0.x, r1, r0.w
rcp r0.y, r1.z
mul r1.z, r0.x, r0.y
mul r1.w, r1.z, r1.z
mul r0.xy, v3.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r2
mad_pp r0.xyz, r1.y, r0, r2
mad r2.w, r1, c14.y, c14.z
mad r1.y, r2.w, r1.w, c14.w
mad r1.y, r1, r1.w, c15.x
mul r2.w, v0.x, c8.x
add_pp r2.xyz, -r0, c11.w
mul_sat r2.w, r2, c13.z
mad_pp r2.xyz, r2.w, r2, r0
mad r1.y, r1, r1.w, c15
mad r0.x, r1.y, r1.w, c15.z
mul r0.y, r0.x, r1.z
dp4_pp r0.z, c2, c2
rsq_pp r0.x, r0.z
mul_pp r3.xyz, r0.x, c2
add r0.x, r1, -r0.w
add r0.z, -r0.y, c15.w
cmp r1.x, -r0, r0.y, r0.z
add r1.y, -r1.x, c13.w
cmp r1.x, v3.z, r1, r1.y
dp3_pp r0.x, v2, -r3
mul_pp r0.xyz, v2, r0.x
mad_pp r0.xyz, -r0, c13.z, -r3
dp3_pp_sat r2.w, v1, r0
add r0.y, -r0.w, c11.w
mad r0.x, r0.w, c12.z, c12.w
mad r0.x, r0.w, r0, c13
mad r0.x, r0.w, r0, c13.y
abs r0.w, v3.y
add r1.z, -r0.w, c11.w
mad r1.y, r0.w, c12.z, c12.w
mad r1.y, r1, r0.w, c13.x
cmp r1.x, v3, r1, -r1
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v3.z, c12, c12.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c13, r0.y
rsq r1.z, r1.z
mad r0.w, r1.y, r0, c13.y
rcp r1.z, r1.z
mul r1.y, r0.w, r1.z
cmp r0.w, v3.y, c12.x, c12.y
mul r1.z, r0.w, r1.y
mad r0.y, -r1.z, c13.z, r1
mad r0.z, r0.x, c13.w, r0
mad r0.x, r0.w, c13.w, r0.y
mul r0.y, r0.z, c14.x
dsx r0.w, r0.y
mul r1.y, r0.x, c14.x
dsx r1.zw, v3.xyxy
mul r1.zw, r1, r1
dsy r0.xz, v3.xyyw
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r1.z, r1, r1.w
rsq r0.x, r1.z
rsq r0.z, r0.z
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.z, c16
dsy r0.y, r0
mad r1.x, r1, c16, c16.y
texldd r1, r1, s0, r0.zwzw, r0
mul_pp r1.xyz, r1, r2
pow_pp r0, r2.w, c6.x
dp3_pp_sat r0.y, v2, r3
mov r2.xyz, c3
add_pp r0.z, r0.y, c11.w
mov_pp r0.w, r0.x
frc_pp r0.x, r0.z
mul r2.xyz, c4, r2
mul r2.xyz, r2, r0.w
add_pp_sat r0.x, r0.z, -r0
mul r2.xyz, r0.x, r2
add_pp r0.x, r0.y, c16.z
mul_pp r0.y, r0.x, c3.w
mul_pp_sat r0.w, r0.y, c16
mov r0.x, c9
add r0.xyz, c3, r0.x
mul_pp r1.xyz, r1, c5
mul r2.xyz, r1.w, r2
mad_sat r0.xyz, r0, r0.w, c0
add_pp r0.xyz, r0, r2
mul_pp oC0.xyz, r1, r0
texldp r0.x, v4, s2
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v4.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_CameraDepthTexture] 2D
"ps_3_0
; 122 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord5 v4.xyz
dcl_texcoord6 v5
mul r0.xy, v4, c7.x
mul r1.xy, v4.zyzw, c7.x
mul r2.z, v0.x, c8.x
dsx r4.xy, v4
dsy r4.zw, v4.xyxy
abs r1.w, v4.z
abs r3.xy, v4
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r1.w
rcp r0.w, r0.z
min r0.z, r3.x, r1.w
mul r0.w, r0.z, r0
mul r2.x, r0.w, r0.w
mad r2.y, r2.x, c14, c14.z
mad r2.y, r2, r2.x, c14.w
mul r0.xy, v4.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c11.w
mul_sat r2.z, r2, c13
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c15.x
mad r0.x, r2.y, r2, c15.y
dp4 r0.y, c2, c2
mad r0.x, r0, r2, c15.z
rsq r0.z, r0.y
mul r0.y, r0.x, r0.w
mul r2.xyz, r0.z, c2
dp3_pp r2.w, v2, -r2
add r0.x, r3, -r1.w
add r0.z, -r0.y, c15.w
cmp r0.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c13.z, -r2
add r2.w, -r0, c13
cmp r0.w, v4.z, r0, r2
cmp r2.w, v4.x, r0, -r0
dp3_pp_sat r3.x, v1, r0
pow_pp r0, r3.x, c6.x
add r0.z, -r1.w, c11.w
mad r0.y, r1.w, c12.z, c12.w
mad r0.y, r1.w, r0, c13.x
mad r0.y, r1.w, r0, c13
abs r1.w, v4.y
mad r3.z, r2.w, c16.x, c16.y
add r3.x, -r1.w, c11.w
mad r2.w, r1, c12.z, c12
mad r2.w, r2, r1, c13.x
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.y, r0
cmp r0.y, v4.z, c12.x, c12
mul r0.w, r0.y, r0.z
mad r0.w, -r0, c13.z, r0.z
rsq r3.x, r3.x
dp3_pp_sat r2.z, v2, r2
mad r1.w, r2, r1, c13.y
rcp r3.x, r3.x
mul r2.w, r1, r3.x
cmp r1.w, v4.y, c12.x, c12.y
mul r3.x, r1.w, r2.w
mad r0.z, -r3.x, c13, r2.w
mad r0.w, r0.y, c13, r0
mad r0.y, r1.w, c13.w, r0.z
mul r0.z, r0.w, c14.x
dsy r0.w, r0.z
mul r3.w, r0.y, c14.x
mul r4.xy, r4, r4
add r0.y, r4.x, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
dsx r3.y, r0.z
mul r4.zw, r4, r4
add r0.z, r4, r4.w
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, c16.x
mul r3.x, r0.y, c16
texldd r3, r3.zwzw, s0, r3, r0.zwzw
mov_pp r1.w, r0.x
rcp r0.x, v3.w
mad r2.xy, v3, r0.x, c16.y
texld r0.w, r2, s2
add_pp r2.x, r2.z, c11.w
frc_pp r2.y, r2.x
dp3 r0.x, v3, v3
cmp r0.y, -v3.z, c12.x, c12
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.w, r0.y, r0.x
mul r0.xyz, r0.w, c3
mul r0.xyz, r0, c4
mul r0.xyz, r0, r1.w
add_pp_sat r2.x, r2, -r2.y
add_pp r1.w, r2.z, c16.z
mul r0.xyz, r2.x, r0
mul_pp r1.w, r1, c3
mul_pp r1.w, r1, r0
mov r0.w, c9.x
mul_pp r1.xyz, r3, r1
mul r0.xyz, r3.w, r0
mul_pp_sat r1.w, r1, c16
add r2.xyz, c3, r0.w
mad_sat r2.xyz, r2, r1.w, c0
add_pp r2.xyz, r2, r0
mul_pp r0.xyz, r1, c5
mul_pp oC0.xyz, r0, r2
texldp r0.x, v5, s4
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v5.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
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

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
SetTexture 4 [_CameraDepthTexture] 2D
"ps_3_0
; 118 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord5 v4.xyz
dcl_texcoord6 v5
mul r0.xy, v4, c7.x
mul r1.xy, v4.zyzw, c7.x
mul r2.z, v0.x, c8.x
dsx r4.xy, v4
dsy r4.zw, v4.xyxy
abs r1.w, v4.z
abs r3.xy, v4
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r1.w
rcp r0.w, r0.z
min r0.z, r3.x, r1.w
mul r0.w, r0.z, r0
mul r2.x, r0.w, r0.w
mad r2.y, r2.x, c14, c14.z
mad r2.y, r2, r2.x, c14.w
mul r0.xy, v4.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c11.w
mul_sat r2.z, r2, c13
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c15.x
mad r0.x, r2.y, r2, c15.y
dp4 r0.y, c2, c2
mad r0.x, r0, r2, c15.z
rsq r0.z, r0.y
mul r2.xyz, r0.z, c2
mul r0.y, r0.x, r0.w
dp3_pp r2.w, v2, -r2
add r0.x, r3, -r1.w
add r0.z, -r0.y, c15.w
cmp r0.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c13.z, -r2
add r2.w, -r0, c13
cmp r0.w, v4.z, r0, r2
cmp r2.w, v4.x, r0, -r0
dp3_pp_sat r3.x, v1, r0
pow_pp r0, r3.x, c6.x
add r0.z, -r1.w, c11.w
mad r0.y, r1.w, c12.z, c12.w
mad r0.y, r1.w, r0, c13.x
mad r0.y, r1.w, r0, c13
abs r1.w, v4.y
mad r3.z, r2.w, c16.x, c16.y
add r3.x, -r1.w, c11.w
mad r2.w, r1, c12.z, c12
mad r2.w, r2, r1, c13.x
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.y, r0
cmp r0.y, v4.z, c12.x, c12
mul r0.w, r0.y, r0.z
mad r0.w, -r0, c13.z, r0.z
rsq r3.x, r3.x
mad r1.w, r2, r1, c13.y
rcp r3.x, r3.x
mul r2.w, r1, r3.x
cmp r1.w, v4.y, c12.x, c12.y
mul r3.x, r1.w, r2.w
mad r0.z, -r3.x, c13, r2.w
mad r0.w, r0.y, c13, r0
mad r0.y, r1.w, c13.w, r0.z
mul r0.z, r0.w, c14.x
dp3_pp_sat r1.w, v2, r2
add_pp r2.x, r1.w, c11.w
frc_pp r2.y, r2.x
add_pp r1.w, r1, c16.z
dsy r0.w, r0.z
mul r3.w, r0.y, c14.x
mul r4.xy, r4, r4
add r0.y, r4.x, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
dsx r3.y, r0.z
mul r4.zw, r4, r4
add r0.z, r4, r4.w
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, c16.x
mul r3.x, r0.y, c16
texldd r3, r3.zwzw, s0, r3, r0.zwzw
mov_pp r2.w, r0.x
dp3 r0.x, v3, v3
mul_pp r1.xyz, r3, r1
texld r0.x, r0.x, s2
texld r0.w, v3, s3
mul r0.w, r0.x, r0
mul r0.xyz, r0.w, c3
mul r0.xyz, r0, c4
mul_pp r1.w, r1, c3
mul_pp r1.w, r1, r0
add_pp_sat r2.x, r2, -r2.y
mul r0.xyz, r0, r2.w
mul r0.xyz, r2.x, r0
mov r0.w, c9.x
mul r0.xyz, r3.w, r0
mul_pp_sat r1.w, r1, c16
add r2.xyz, c3, r0.w
mad_sat r2.xyz, r2, r1.w, c0
add_pp r2.xyz, r2, r0
mul_pp r0.xyz, r1, c5
mul_pp oC0.xyz, r0, r2
texldp r0.x, v5, s4
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v5.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 116 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord5 v4.xyz
dcl_texcoord6 v5
mul r0.xy, v4, c7.x
mul r1.xy, v4.zyzw, c7.x
mul r2.w, v0.x, c8.x
dsx r4.xy, v4
dsy r4.zw, v4.xyxy
abs r0.w, v4.z
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r2.xyz, r1, -r0
abs r1.xy, v4
mad_pp r2.xyz, r1.x, r2, r0
max r0.z, r1.x, r0.w
rcp r1.z, r0.z
min r0.z, r1.x, r0.w
mul r1.z, r0, r1
mul r0.xy, v4.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r2
mad_pp r0.xyz, r1.y, r0, r2
mul r1.w, r1.z, r1.z
mad r1.y, r1.w, c14, c14.z
mad r1.y, r1, r1.w, c14.w
mad r1.y, r1, r1.w, c15.x
mad r1.y, r1, r1.w, c15
mad r1.y, r1, r1.w, c15.z
mul r1.y, r1, r1.z
add_pp r2.xyz, -r0, c11.w
mul_sat r2.w, r2, c13.z
mad_pp r0.xyz, r2.w, r2, r0
dp4_pp r2.x, c2, c2
rsq_pp r1.w, r2.x
mul_pp r2.xyz, r1.w, c2
dp3_pp r2.w, v2, -r2
add r1.x, r1, -r0.w
add r1.z, -r1.y, c15.w
cmp r1.w, -r1.x, r1.y, r1.z
mul_pp r1.xyz, v2, r2.w
mad_pp r1.xyz, -r1, c13.z, -r2
dp3_pp_sat r1.y, v1, r1
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c11.w
pow_pp r3, r1.y, c6.x
add r2.w, -r1, c13
cmp r1.w, v4.z, r1, r2
abs r1.z, v4.y
cmp r1.x, v4, r1.w, -r1.w
mad r3.z, r1.x, c16.x, c16.y
frc_pp r2.z, r2.y
add r1.y, -r0.w, c11.w
mad r1.x, r0.w, c12.z, c12.w
mad r1.x, r0.w, r1, c13
add r2.w, -r1.z, c11
mad r1.w, r1.z, c12.z, c12
mad r1.w, r1, r1.z, c13.x
rsq r1.y, r1.y
rsq r2.w, r2.w
add_pp r2.x, r2, c16.z
mad r0.w, r0, r1.x, c13.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v4.z, c12.x, c12.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c13.z, r1.x
mad r1.z, r1.w, r1, c13.y
rcp r2.w, r2.w
mul r1.w, r1.z, r2
cmp r1.z, v4.y, c12.x, c12.y
mul r2.w, r1.z, r1
mad r1.x, -r2.w, c13.z, r1.w
mad r1.y, r0.w, c13.w, r1
mad r0.w, r1.z, c13, r1.x
mul r1.x, r1.y, c14
mul r3.w, r0, c14.x
mul r4.xy, r4, r4
add r0.w, r4.x, r4.y
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r1.z, r0.w, c16.x
texld r0.w, v3, s2
dsx r1.w, r1.x
dsy r1.y, r1.x
mul r4.zw, r4, r4
add r1.x, r4.z, r4.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c16
texldd r1, r3.zwzw, s0, r1.zwzw, r1
mul_pp r0.xyz, r1, r0
mul r1.xyz, r0.w, c3
mul_pp r0.xyz, r0, c5
add_pp_sat r2.y, r2, -r2.z
mul_pp r2.x, r2, c3.w
mov_pp r2.w, r3.x
mul r1.xyz, r1, c4
mul r1.xyz, r1, r2.w
mul r1.xyz, r2.y, r1
mul r1.xyz, r1.w, r1
mul_pp r1.w, r2.x, r0
mov r0.w, c9.x
mul_pp_sat r1.w, r1, c16
add r2.xyz, c3, r0.w
mad_sat r2.xyz, r2, r1.w, c0
add_pp r1.xyz, r2, r1
mul_pp oC0.xyz, r0, r1
texldp r0.x, v5, s3
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v5.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightShadowData]
Vector 4 [_LightColor0]
Vector 5 [_SpecColor]
Vector 6 [_Color]
Float 7 [_Shininess]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c12, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c13, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c14, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r0.xy, v5, c8.x
mul r1.xy, v5.zyzw, c8.x
mul r2.z, v0.x, c9.x
dsx r4.xy, v5
dsy r4.zw, v5.xyxy
abs r1.w, v5.z
abs r3.xy, v5
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r1.w
rcp r0.w, r0.z
min r0.z, r3.x, r1.w
mul r0.w, r0.z, r0
mul r2.x, r0.w, r0.w
mad r2.y, r2.x, c15, c15.z
mad r2.y, r2, r2.x, c15.w
mul r0.xy, v5.zxzw, c8.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c12.w
mul_sat r2.z, r2, c14
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c16.x
mad r0.x, r2.y, r2, c16.y
dp4 r0.y, c2, c2
mad r0.x, r0, r2, c16.z
rsq r0.z, r0.y
mul r2.xyz, r0.z, c2
mul r0.y, r0.x, r0.w
dp3_pp r2.w, v2, -r2
add r0.x, r3, -r1.w
add r0.z, -r0.y, c16.w
cmp r0.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c14.z, -r2
add r2.w, -r0, c14
cmp r0.w, v5.z, r0, r2
cmp r2.w, v5.x, r0, -r0
dp3_pp_sat r3.x, v1, r0
pow_pp r0, r3.x, c7.x
add r0.z, -r1.w, c12.w
mad r0.y, r1.w, c13.z, c13.w
mad r0.y, r1.w, r0, c14.x
mad r0.y, r1.w, r0, c14
abs r1.w, v5.y
mad r3.z, r2.w, c17.x, c17.y
add r3.x, -r1.w, c12.w
mad r2.w, r1, c13.z, c13
mad r2.w, r2, r1, c14.x
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.y, r0
cmp r0.y, v5.z, c13.x, c13
mul r0.w, r0.y, r0.z
mad r0.w, -r0, c14.z, r0.z
rsq r3.x, r3.x
mad r1.w, r2, r1, c14.y
rcp r3.x, r3.x
mul r2.w, r1, r3.x
cmp r1.w, v5.y, c13.x, c13.y
mul r3.x, r1.w, r2.w
mad r0.z, -r3.x, c14, r2.w
mad r0.w, r0.y, c14, r0
mad r0.y, r1.w, c14.w, r0.z
mul r0.z, r0.w, c15.x
dsy r0.w, r0.z
mul r3.w, r0.y, c15.x
mul r4.xy, r4, r4
add r0.y, r4.x, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
dsx r3.y, r0.z
mul r4.zw, r4, r4
add r0.z, r4, r4.w
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, c17.x
mul r3.x, r0.y, c17
texldd r3, r3.zwzw, s0, r3, r0.zwzw
mov_pp r0.y, r0.x
dp3_pp_sat r0.z, v2, r2
mul_pp r1.xyz, r3, r1
texldp r0.x, v4, s4
rcp r0.w, v4.w
mad r0.w, -v4.z, r0, r0.x
mov r1.w, c3.x
cmp r2.z, r0.w, c12.w, r1.w
rcp r0.x, v3.w
mad r2.xy, v3, r0.x, c17.y
dp3 r0.x, v3, v3
texld r0.w, r2, s2
cmp r1.w, -v3.z, c13.x, c13.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s3
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r2.z
add_pp r0.w, r0.z, c12
mul r2.xyz, r0.x, c4
frc_pp r1.w, r0
mul r2.xyz, r2, c5
mul r2.xyz, r2, r0.y
add_pp_sat r0.w, r0, -r1
add_pp r0.y, r0.z, c17.z
mul r2.xyz, r0.w, r2
mul_pp r0.y, r0, c4.w
mul_pp r0.y, r0, r0.x
mul_pp_sat r0.w, r0.y, c17
mov r0.x, c10
add r0.xyz, c4, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mul r2.xyz, r3.w, r2
add_pp r2.xyz, r0, r2
mul_pp r0.xyz, r1, c6
mul_pp oC0.xyz, r0, r2
texldp r0.x, v6, s5
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c12, c12.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c12
mul_sat r0.y, r0, c11.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c12.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightShadowData]
Vector 4 [_LightColor0]
Vector 5 [_SpecColor]
Vector 6 [_Color]
Float 7 [_Shininess]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [_CameraDepthTexture] 2D
"ps_3_0
; 126 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c12, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c13, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c14, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r0.xy, v5, c8.x
mul r1.xy, v5.zyzw, c8.x
mul r2.z, v0.x, c9.x
dsx r4.xy, v5
dsy r4.zw, v5.xyxy
abs r1.w, v5.z
abs r3.xy, v5
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r1.w
rcp r0.w, r0.z
min r0.z, r3.x, r1.w
mul r0.w, r0.z, r0
mul r2.x, r0.w, r0.w
mad r2.y, r2.x, c15, c15.z
mad r2.y, r2, r2.x, c15.w
mul r0.xy, v5.zxzw, c8.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c12.w
mul_sat r2.z, r2, c14
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c16.x
mad r0.x, r2.y, r2, c16.y
dp4 r0.y, c2, c2
mad r0.x, r0, r2, c16.z
rsq r0.z, r0.y
mul r2.xyz, r0.z, c2
mul r0.y, r0.x, r0.w
dp3_pp r2.w, v2, -r2
add r0.x, r3, -r1.w
add r0.z, -r0.y, c16.w
cmp r0.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c14.z, -r2
add r2.w, -r0, c14
cmp r0.w, v5.z, r0, r2
cmp r2.w, v5.x, r0, -r0
dp3_pp_sat r3.x, v1, r0
pow_pp r0, r3.x, c7.x
add r0.z, -r1.w, c12.w
mad r0.y, r1.w, c13.z, c13.w
mad r0.y, r1.w, r0, c14.x
mad r0.y, r1.w, r0, c14
abs r1.w, v5.y
mad r3.z, r2.w, c17.x, c17.y
add r3.x, -r1.w, c12.w
mad r2.w, r1, c13.z, c13
mad r2.w, r2, r1, c14.x
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.y, r0
cmp r0.y, v5.z, c13.x, c13
mul r0.w, r0.y, r0.z
mad r0.w, -r0, c14.z, r0.z
rsq r3.x, r3.x
mad r1.w, r2, r1, c14.y
rcp r3.x, r3.x
mul r2.w, r1, r3.x
cmp r1.w, v5.y, c13.x, c13.y
mul r3.x, r1.w, r2.w
mad r0.z, -r3.x, c14, r2.w
mad r0.w, r0.y, c14, r0
mad r0.y, r1.w, c14.w, r0.z
mul r0.z, r0.w, c15.x
dsy r0.w, r0.z
mul r3.w, r0.y, c15.x
mul r4.xy, r4, r4
add r0.y, r4.x, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
dsx r3.y, r0.z
mul r4.zw, r4, r4
add r0.z, r4, r4.w
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, c17.x
mul r3.x, r0.y, c17
texldd r3, r3.zwzw, s0, r3, r0.zwzw
mov_pp r0.y, r0.x
mov r0.x, c3
add r1.w, c12, -r0.x
dp3_pp_sat r0.z, v2, r2
rcp r0.w, v3.w
mad r2.xy, v3, r0.w, c17.y
texldp r0.x, v4, s4
mad r2.z, r0.x, r1.w, c3.x
dp3 r0.x, v3, v3
mul_pp r1.xyz, r3, r1
texld r0.w, r2, s2
cmp r1.w, -v3.z, c13.x, c13.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s3
mul_pp r0.x, r0.w, r0
mul_pp r0.x, r0, r2.z
add_pp r0.w, r0.z, c12
mul r2.xyz, r0.x, c4
frc_pp r1.w, r0
mul r2.xyz, r2, c5
mul r2.xyz, r2, r0.y
add_pp_sat r0.w, r0, -r1
add_pp r0.y, r0.z, c17.z
mul r2.xyz, r0.w, r2
mul_pp r0.y, r0, c4.w
mul_pp r0.y, r0, r0.x
mul_pp_sat r0.w, r0.y, c17
mov r0.x, c10
add r0.xyz, c4, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mul r2.xyz, r3.w, r2
add_pp r2.xyz, r0, r2
mul_pp r0.xyz, r1, c6
mul_pp oC0.xyz, r0, r2
texldp r0.x, v6, s5
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c12, c12.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c12
mul_sat r0.y, r0, c11.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c12.y
mad oC0.w, r0.x, r0.y, r0.z
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

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 116 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord5 v4.xyz
dcl_texcoord6 v5
mul r0.xy, v4, c7.x
mul r1.xy, v4.zyzw, c7.x
mul r2.z, v0.x, c8.x
dsx r4.xy, v4
dsy r4.zw, v4.xyxy
abs r0.w, v4.z
abs r3.xy, v4
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r0.w
rcp r1.w, r0.z
min r0.z, r3.x, r0.w
mul r1.w, r0.z, r1
mul r2.x, r1.w, r1.w
mad r2.y, r2.x, c14, c14.z
mad r2.y, r2, r2.x, c14.w
mul r0.xy, v4.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c11.w
mul_sat r2.z, r2, c13
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c15.x
mad r0.x, r2.y, r2, c15.y
dp4_pp r0.y, c2, c2
mad r0.x, r0, r2, c15.z
rsq_pp r0.z, r0.y
mul r0.y, r0.x, r1.w
mul_pp r2.xyz, r0.z, c2
add r0.x, r3, -r0.w
add r0.z, -r0.y, c15.w
dp3_pp r2.w, v2, -r2
cmp r1.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c13.z, -r2
dp3_pp_sat r0.y, v1, r0
pow_pp r3, r0.y, c6.x
add r2.w, -r1, c13
cmp r1.w, v4.z, r1, r2
cmp r0.x, v4, r1.w, -r1.w
mad r3.z, r0.x, c16.x, c16.y
add r0.y, -r0.w, c11.w
mad r0.x, r0.w, c12.z, c12.w
mad r0.x, r0.w, r0, c13
mad r0.x, r0.w, r0, c13.y
abs r0.w, v4.y
add r2.w, -r0, c11
mad r1.w, r0, c12.z, c12
mad r1.w, r1, r0, c13.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v4.z, c12, c12.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c13, r0.y
rsq r2.w, r2.w
mad r0.w, r1, r0, c13.y
rcp r2.w, r2.w
mul r1.w, r0, r2
cmp r0.w, v4.y, c12.x, c12.y
mul r2.w, r0, r1
mad r0.y, -r2.w, c13.z, r1.w
mad r0.z, r0.x, c13.w, r0
mad r0.x, r0.w, c13.w, r0.y
mul r0.y, r0.z, c14.x
mul r3.w, r0.x, c14.x
dsx r0.w, r0.y
mul r4.xy, r4, r4
mul r4.zw, r4, r4
add r0.x, r4, r4.y
add r0.z, r4, r4.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r1.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.w, c16
dsy r0.y, r0
texldd r0, r3.zwzw, s0, r0.zwzw, r0
mul_pp r1.xyz, r0, r1
dp3_pp_sat r0.y, v2, r2
add_pp r0.z, r0.y, c11.w
texldp r0.x, v3, s2
mul r2.xyz, r0.x, c3
frc_pp r1.w, r0.z
add_pp r0.y, r0, c16.z
mul_pp r0.y, r0, c3.w
mul_pp r0.y, r0, r0.x
add_pp_sat r0.z, r0, -r1.w
mov_pp r2.w, r3.x
mul r2.xyz, r2, c4
mul r2.xyz, r2, r2.w
mul r2.xyz, r0.z, r2
mul r2.xyz, r0.w, r2
mul_pp_sat r0.w, r0.y, c16
mov r0.x, c9
add r0.xyz, c3, r0.x
mad_sat r0.xyz, r0, r0.w, c0
add_pp r2.xyz, r0, r2
mul_pp r0.xyz, r1, c5
mul_pp oC0.xyz, r0, r2
texldp r0.x, v5, s3
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v5.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_CameraDepthTexture] 2D
"ps_3_0
; 117 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c11, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r0.xy, v5, c7.x
mul r1.xy, v5.zyzw, c7.x
mul r2.z, v0.x, c8.x
dsx r4.xy, v5
dsy r4.zw, v5.xyxy
abs r1.w, v5.z
abs r3.xy, v5
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r3.x, r1, r0
max r0.z, r3.x, r1.w
rcp r0.w, r0.z
min r0.z, r3.x, r1.w
mul r0.w, r0.z, r0
mul r2.x, r0.w, r0.w
mad r2.y, r2.x, c14, c14.z
mad r2.y, r2, r2.x, c14.w
mul r0.xy, v5.zxzw, c7.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r3.y, r0, r1
add_pp r1.xyz, -r0, c11.w
mul_sat r2.z, r2, c13
mad_pp r1.xyz, r2.z, r1, r0
mad r2.y, r2, r2.x, c15.x
mad r0.x, r2.y, r2, c15.y
dp4_pp r0.y, c2, c2
mad r0.x, r0, r2, c15.z
rsq_pp r0.z, r0.y
mul_pp r2.xyz, r0.z, c2
mul r0.y, r0.x, r0.w
dp3_pp r2.w, v2, -r2
add r0.x, r3, -r1.w
add r0.z, -r0.y, c15.w
cmp r0.w, -r0.x, r0.y, r0.z
mul_pp r0.xyz, v2, r2.w
mad_pp r0.xyz, -r0, c13.z, -r2
add r2.w, -r0, c13
cmp r0.w, v5.z, r0, r2
cmp r2.w, v5.x, r0, -r0
dp3_pp_sat r3.x, v1, r0
pow_pp r0, r3.x, c6.x
add r0.z, -r1.w, c11.w
mad r0.y, r1.w, c12.z, c12.w
mad r0.y, r1.w, r0, c13.x
mad r0.y, r1.w, r0, c13
abs r1.w, v5.y
mad r3.z, r2.w, c16.x, c16.y
add r3.x, -r1.w, c11.w
mad r2.w, r1, c12.z, c12
mad r2.w, r2, r1, c13.x
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.y, r0
cmp r0.y, v5.z, c12.x, c12
mul r0.w, r0.y, r0.z
mad r0.w, -r0, c13.z, r0.z
rsq r3.x, r3.x
mad r1.w, r2, r1, c13.y
rcp r3.x, r3.x
mul r2.w, r1, r3.x
cmp r1.w, v5.y, c12.x, c12.y
mul r3.x, r1.w, r2.w
mad r0.z, -r3.x, c13, r2.w
mad r0.w, r0.y, c13, r0
mad r0.y, r1.w, c13.w, r0.z
mul r0.z, r0.w, c14.x
dp3_pp_sat r1.w, v2, r2
add_pp r2.x, r1.w, c11.w
frc_pp r2.y, r2.x
add_pp r1.w, r1, c16.z
dsy r0.w, r0.z
mul r3.w, r0.y, c14.x
mul r4.xy, r4, r4
add r0.y, r4.x, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
dsx r3.y, r0.z
mul r4.zw, r4, r4
add r0.z, r4, r4.w
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, c16.x
mul r3.x, r0.y, c16
texldd r3, r3.zwzw, s0, r3, r0.zwzw
mov_pp r2.w, r0.x
mul_pp r1.xyz, r3, r1
texldp r0.x, v4, s2
texld r0.w, v3, s3
mul r0.w, r0, r0.x
mul r0.xyz, r0.w, c3
mul r0.xyz, r0, c4
mul_pp r1.w, r1, c3
mul_pp r1.w, r1, r0
add_pp_sat r2.x, r2, -r2.y
mul r0.xyz, r0, r2.w
mul r0.xyz, r2.x, r0
mov r0.w, c9.x
mul r0.xyz, r3.w, r0
mul_pp_sat r1.w, r1, c16
add r2.xyz, c3, r0.w
mad_sat r2.xyz, r2, r1.w, c0
add_pp r2.xyz, r2, r0
mul_pp r0.xyz, r1, c5
mul_pp oC0.xyz, r0, r2
texldp r0.x, v6, s4
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c11, c11.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c11
mul_sat r0.y, r0, c10.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c11.y
mad oC0.w, r0.x, r0.y, r0.z
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightPositionRange]
Vector 4 [_LightShadowData]
Vector 5 [_LightColor0]
Vector 6 [_SpecColor]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_CameraDepthTexture] 2D
"ps_3_0
; 126 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
def c13, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 4.03944778, 0, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r0.xy, v5, c9.x
mul r1.xy, v5.zyzw, c9.x
abs r0.w, v5.z
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r2.xyz, r1, -r0
abs r1.xy, v5
mad_pp r2.xyz, r1.x, r2, r0
max r1.z, r1.x, r0.w
min r0.x, r1, r0.w
rcp r0.y, r1.z
mul r1.z, r0.x, r0.y
mul r1.w, r1.z, r1.z
mul r0.xy, v5.zxzw, c9.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r2
mad_pp r0.xyz, r1.y, r0, r2
mad r2.w, r1, c16.y, c16.z
mad r1.y, r2.w, r1.w, c16.w
mad r1.y, r1, r1.w, c17.x
mul r2.w, v0.x, c10.x
add_pp r2.xyz, -r0, c13.w
mul_sat r2.w, r2, c15.z
mad_pp r3.xyz, r2.w, r2, r0
mad r1.y, r1, r1.w, c17
mad r0.x, r1.y, r1.w, c17.z
mul r0.y, r0.x, r1.z
dp4 r0.z, c2, c2
rsq r0.x, r0.z
mul r2.xyz, r0.x, c2
add r0.x, r1, -r0.w
add r0.z, -r0.y, c17.w
cmp r1.x, -r0, r0.y, r0.z
add r1.y, -r1.x, c15.w
cmp r1.x, v5.z, r1, r1.y
dp3_pp r0.x, v2, -r2
mul_pp r0.xyz, v2, r0.x
mad_pp r0.xyz, -r0, c15.z, -r2
dp3_pp_sat r2.w, v1, r0
add r0.y, -r0.w, c13.w
mad r0.x, r0.w, c14.z, c14.w
mad r0.x, r0.w, r0, c15
mad r0.x, r0.w, r0, c15.y
abs r0.w, v5.y
add r1.z, -r0.w, c13.w
mad r1.y, r0.w, c14.z, c14.w
mad r1.y, r1, r0.w, c15.x
cmp r1.x, v5, r1, -r1
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v5.z, c14, c14.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c15, r0.y
rsq r1.z, r1.z
mad r0.w, r1.y, r0, c15.y
rcp r1.z, r1.z
mul r1.y, r0.w, r1.z
cmp r0.w, v5.y, c14.x, c14.y
mul r1.z, r0.w, r1.y
mad r0.y, -r1.z, c15.z, r1
mad r0.z, r0.x, c15.w, r0
mad r0.x, r0.w, c15.w, r0.y
mul r0.y, r0.z, c16.x
mul r1.y, r0.x, c16.x
dsx r0.w, r0.y
dsx r1.zw, v5.xyxy
mul r1.zw, r1, r1
dsy r0.xz, v5.xyyw
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r1.z, r1, r1.w
rsq r0.x, r1.z
rsq r0.z, r0.z
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c18.x
mad r1.x, r1, c18, c18.y
mul r0.x, r1.z, c18
dsy r0.y, r0
texldd r0, r1, s0, r0.zwzw, r0
mul_pp r3.xyz, r0, r3
pow_pp r1, r2.w, c8.x
mov_pp r0.y, r1.x
texld r1, v4, s2
dp4 r0.z, r1, c19
dp3 r0.x, v4, v4
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c3.w
mad r0.z, -r0.x, c18.w, r0
mov r1.x, c4
dp3 r0.x, v3, v3
cmp r0.z, r0, c13.w, r1.x
texld r0.x, r0.x, s3
mul r0.x, r0, r0.z
dp3_pp_sat r0.z, v2, r2
add_pp r1.w, r0.z, c13
mul r1.xyz, r0.x, c5
mul r1.xyz, r1, c6
mul r1.xyz, r1, r0.y
add_pp r0.y, r0.z, c18.z
frc_pp r2.x, r1.w
add_pp_sat r1.w, r1, -r2.x
mul r1.xyz, r1.w, r1
mul_pp r0.y, r0, c5.w
mul_pp r0.y, r0, r0.x
mul r1.xyz, r0.w, r1
mul_pp_sat r0.w, r0.y, c20.x
mov r0.x, c11
add r0.xyz, c5, r0.x
mad_sat r0.xyz, r0, r0.w, c0
add_pp r0.xyz, r0, r1
mul_pp r1.xyz, r3, c7
mul_pp oC0.xyz, r1, r0
texldp r0.x, v6, s4
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c13, c13.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c13
mul_sat r0.y, r0, c12.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c13.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightPositionRange]
Vector 4 [_LightShadowData]
Vector 5 [_LightColor0]
Vector 6 [_SpecColor]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
SetTexture 5 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c13, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 4.03944778, 0, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r0.xy, v5, c9.x
mul r1.xy, v5.zyzw, c9.x
mul r2.w, v0.x, c10.x
dsx r4.xy, v5
dsy r4.zw, v5.xyxy
abs r2.xy, v5
abs r0.w, v5.z
texld r0.xyz, r0, s1
texld r1.xyz, r1, s1
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r2.x, r1, r0
max r0.z, r2.x, r0.w
rcp r1.w, r0.z
min r0.z, r2.x, r0.w
mul r1.w, r0.z, r1
mul r0.xy, v5.zxzw, c9.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mul r2.z, r1.w, r1.w
mad r2.y, r2.z, c16, c16.z
mad r2.y, r2, r2.z, c16.w
add_pp r1.xyz, -r0, c13.w
mul_sat r2.w, r2, c15.z
mad_pp r0.xyz, r2.w, r1, r0
mad r2.y, r2, r2.z, c17.x
mad r1.x, r2.y, r2.z, c17.y
mad r1.x, r1, r2.z, c17.z
mul r2.y, r1.x, r1.w
dp4 r1.y, c2, c2
rsq r1.y, r1.y
mul r1.xyz, r1.y, c2
dp3_pp r2.w, v2, -r1
add r1.w, r2.x, -r0
add r2.z, -r2.y, c17.w
cmp r1.w, -r1, r2.y, r2.z
mul_pp r2.xyz, v2, r2.w
mad_pp r2.xyz, -r2, c15.z, -r1
dp3_pp_sat r2.x, v1, r2
pow_pp r3, r2.x, c8.x
abs r2.y, v5
add r2.w, -r1, c15
cmp r1.w, v5.z, r1, r2
cmp r1.w, v5.x, r1, -r1
mad r3.z, r1.w, c18.x, c18.y
add r2.x, -r0.w, c13.w
mad r1.w, r0, c14.z, c14
mad r1.w, r0, r1, c15.x
add r2.w, -r2.y, c13
mad r2.z, r2.y, c14, c14.w
mad r2.z, r2, r2.y, c15.x
rsq r2.x, r2.x
rsq r2.w, r2.w
mad r0.w, r0, r1, c15.y
rcp r2.x, r2.x
mul r1.w, r0, r2.x
cmp r0.w, v5.z, c14.x, c14.y
mul r2.x, r0.w, r1.w
mad r2.x, -r2, c15.z, r1.w
mad r2.y, r2.z, r2, c15
rcp r2.w, r2.w
mul r2.z, r2.y, r2.w
cmp r2.y, v5, c14.x, c14
mul r2.w, r2.y, r2.z
mad r1.w, -r2, c15.z, r2.z
mad r2.x, r0.w, c15.w, r2
mad r0.w, r2.y, c15, r1
mul r1.w, r2.x, c16.x
mul r3.w, r0, c16.x
mul r4.xy, r4, r4
add r0.w, r4.x, r4.y
rsq r0.w, r0.w
rcp r0.w, r0.w
dsx r2.w, r1
dsy r2.y, r1.w
mul r4.zw, r4, r4
add r1.w, r4.z, r4
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.z, r0.w, c18.x
mul r2.x, r1.w, c18
texldd r2, r3.zwzw, s0, r2.zwzw, r2
mul_pp r2.xyz, r2, r0
texld r0, v4, s2
dp4 r0.y, r0, c19
mov_pp r1.w, r3.x
dp3 r3.x, v4, v4
rsq r3.x, r3.x
rcp r0.x, r3.x
mul r0.x, r0, c3.w
mad r0.x, -r0, c18.w, r0.y
mov r0.z, c4.x
cmp r0.y, r0.x, c13.w, r0.z
dp3 r0.x, v3, v3
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
dp3_pp_sat r0.y, v2, r1
add_pp r0.z, r0.y, c13.w
frc_pp r0.w, r0.z
mul r1.xyz, r0.x, c5
mul r1.xyz, r1, c6
add_pp r0.y, r0, c18.z
mul_pp r0.y, r0, c5.w
mul_pp r0.y, r0, r0.x
add_pp_sat r0.z, r0, -r0.w
mul r1.xyz, r1, r1.w
mul r1.xyz, r0.z, r1
mul_pp_sat r0.w, r0.y, c20.x
mov r0.x, c11
add r0.xyz, c5, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mul r1.xyz, r2.w, r1
add_pp r1.xyz, r0, r1
mul_pp r0.xyz, r2, c7
mul_pp oC0.xyz, r0, r1
texldp r0.x, v6, s5
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c13, c13.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c13
mul_sat r0.y, r0, c12.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c13.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightShadowData]
Vector 4 [_ShadowOffsets0]
Vector 5 [_ShadowOffsets1]
Vector 6 [_ShadowOffsets2]
Vector 7 [_ShadowOffsets3]
Vector 8 [_LightColor0]
Vector 9 [_SpecColor]
Vector 10 [_Color]
Float 11 [_Shininess]
Float 12 [_DetailScale]
Float 13 [_DetailDist]
Float 14 [_MinLight]
Float 15 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [_CameraDepthTexture] 2D
"ps_3_0
; 135 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c16, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c17, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c18, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c19, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c20, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c21, 0.15915494, 0.50000000, -0.01000214, 0.25000000
def c22, 4.03944778, 0, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r1.xy, v5, c12.x
dsx r4.zw, v5.xyxy
abs r0.w, v5.z
abs r2.xy, v5
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r0.xy, v5.zyzw, c12.x
mul r2.z, r1.w, r1.w
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2, c19.y, c19
mad r2.w, r0.z, r2.z, c19
mul r0.xy, v5.zxzw, c12.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
mad r2.w, r2, r2.z, c20.x
mad r2.y, r2.w, r2.z, c20
mad r2.y, r2, r2.z, c20.z
add_pp r1.xyz, -r0, c16.w
mul r1.w, r2.y, r1
mul r2.z, v0.x, c13.x
mul_sat r2.y, r2.z, c18.z
mad_pp r0.xyz, r2.y, r1, r0
dp4 r1.z, c2, c2
add r1.y, -r1.w, c20.w
add r1.x, r2, -r0.w
cmp r1.x, -r1, r1.w, r1.y
rsq r1.z, r1.z
mul r2.xyz, r1.z, c2
add r1.y, -r1.x, c18.w
cmp r1.w, v5.z, r1.x, r1.y
dp3_pp r1.z, v2, -r2
mul_pp r1.xyz, v2, r1.z
mad_pp r3.xyz, -r1, c18.z, -r2
abs r1.z, v5.y
cmp r1.w, v5.x, r1, -r1
mad r4.x, r1.w, c21, c21.y
add r1.y, -r0.w, c16.w
mad r1.x, r0.w, c17.z, c17.w
mad r1.x, r0.w, r1, c18
add r2.w, -r1.z, c16
mad r1.w, r1.z, c17.z, c17
mad r1.w, r1, r1.z, c18.x
rsq r1.y, r1.y
rsq r2.w, r2.w
mad r0.w, r0, r1.x, c18.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v5.z, c17.x, c17.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c18.z, r1.x
mad r1.z, r1.w, r1, c18.y
rcp r2.w, r2.w
mul r1.w, r1.z, r2
cmp r1.z, v5.y, c17.x, c17.y
mul r2.w, r1.z, r1
mad r1.x, -r2.w, c18.z, r1.w
dp3_pp_sat r2.w, v1, r3
rcp r3.z, v4.w
mad r1.y, r0.w, c18.w, r1
mad r0.w, r1.z, c18, r1.x
mul r1.x, r1.y, c19
mul r4.y, r0.w, c19.x
mul r4.zw, r4, r4
add r0.w, r4.z, r4
rsq r0.w, r0.w
dsx r1.w, r1.x
dsy r1.y, r1.x
dsy r1.xz, v5.xyyw
mul r1.xz, r1, r1
add r1.x, r1, r1.z
rcp r0.w, r0.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.z, r0.w, c21.x
mul r1.x, r1, c21
texldd r1, r4, s0, r1.zwzw, r1
mul_pp r1.xyz, r1, r0
pow_pp r0, r2.w, c11.x
mad r3.xy, v4, r3.z, c7
mov_pp r2.w, r0.x
texld r0.x, r3, s4
mad r3.xy, v4, r3.z, c6
mov r0.w, r0.x
texld r0.x, r3, s4
mad r3.xy, v4, r3.z, c5
mov r0.z, r0.x
texld r0.x, r3, s4
mad r3.xy, v4, r3.z, c4
mov r0.y, r0.x
texld r0.x, r3, s4
mov r3.x, c3
mad r0, -v4.z, r3.z, r0
cmp r0, r0, c16.w, r3.x
dp4_pp r0.z, r0, c21.w
rcp r3.x, v3.w
mad r3.xy, v3, r3.x, c21.y
dp3 r0.x, v3, v3
texld r0.w, r3, s2
cmp r0.y, -v3.z, c17.x, c17
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, r0.z
dp3_pp_sat r0.y, v2, r2
add_pp r0.z, r0.y, c16.w
frc_pp r0.w, r0.z
mul r2.xyz, r0.x, c8
mul r2.xyz, r2, c9
add_pp r0.y, r0, c21.z
mul_pp r0.y, r0, c8.w
mul_pp r0.y, r0, r0.x
add_pp_sat r0.z, r0, -r0.w
mul r2.xyz, r2, r2.w
mul r2.xyz, r0.z, r2
mul_pp_sat r0.w, r0.y, c22.x
mov r0.x, c14
add r0.xyz, c8, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mul r2.xyz, r1.w, r2
add_pp r2.xyz, r0, r2
mul_pp r0.xyz, r1, c10
mul_pp oC0.xyz, r0, r2
texldp r0.x, v6, s5
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c16, c16.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c16
mul_sat r0.y, r0, c15.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c16.y
mad oC0.w, r0.x, r0.y, r0.z
"
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
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightShadowData]
Vector 4 [_ShadowOffsets0]
Vector 5 [_ShadowOffsets1]
Vector 6 [_ShadowOffsets2]
Vector 7 [_ShadowOffsets3]
Vector 8 [_LightColor0]
Vector 9 [_SpecColor]
Vector 10 [_Color]
Float 11 [_Shininess]
Float 12 [_DetailScale]
Float 13 [_DetailDist]
Float 14 [_MinLight]
Float 15 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [_CameraDepthTexture] 2D
"ps_3_0
; 134 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c16, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c17, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c18, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c19, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c20, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c21, 0.15915494, 0.50000000, -0.01000214, 0.25000000
def c22, 4.03944778, 0, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r1.xy, v5, c12.x
dsy r3.xy, v5
abs r0.w, v5.z
abs r2.xy, v5
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mad r0.x, r2.z, c19.y, c19.z
mad r0.x, r0, r2.z, c19.w
mad r2.w, r0.x, r2.z, c20.x
mul r0.xy, v5.zyzw, c12.x
mad r2.w, r2, r2.z, c20.y
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c20
mul r1.w, r0.z, r1
mul r0.xy, v5.zxzw, c12.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
add_pp r1.xyz, -r0, c16.w
rcp r2.w, v4.w
add r2.x, r2, -r0.w
add r2.z, -r1.w, c20.w
cmp r1.w, -r2.x, r1, r2.z
add r2.x, -r1.w, c18.w
cmp r1.w, v5.z, r1, r2.x
mul r2.x, v0, c13
mul_sat r2.x, r2, c18.z
mad_pp r2.xyz, r2.x, r1, r0
cmp r1.w, v5.x, r1, -r1
add r0.y, -r0.w, c16.w
mad r0.x, r0.w, c17.z, c17.w
mad r0.x, r0.w, r0, c18
mad r0.x, r0.w, r0, c18.y
abs r0.w, v5.y
add r1.z, -r0.w, c16.w
mad r1.y, r0.w, c17.z, c17.w
mad r1.y, r1, r0.w, c18.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v5.z, c17, c17.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c18, r0.y
rsq r1.z, r1.z
mad r0.w, r1.y, r0, c18.y
rcp r1.z, r1.z
mul r1.y, r0.w, r1.z
cmp r0.w, v5.y, c17.x, c17.y
mul r1.z, r0.w, r1.y
mad r0.y, -r1.z, c18.z, r1
mad r0.z, r0.x, c18.w, r0
mad r0.x, r0.w, c18.w, r0.y
mul r0.y, r0.z, c19.x
dsx r0.w, r0.y
mad r1.x, r1.w, c21, c21.y
mul r3.xy, r3, r3
add r0.z, r3.x, r3.y
dsx r1.zw, v5.xyxy
mul r1.zw, r1, r1
mul r1.y, r0.x, c19.x
add r0.x, r1.z, r1.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c21.x
mul r0.x, r1.z, c21
dsy r0.y, r0
texldd r1, r1, s0, r0.zwzw, r0
mul_pp r1.xyz, r1, r2
mad r0.xyz, v4, r2.w, c7
texld r0.x, r0, s4
mad r2.xyz, v4, r2.w, c6
mov_pp r0.w, r0.x
texld r0.x, r2, s4
mad r2.xyz, v4, r2.w, c5
mov_pp r0.z, r0.x
texld r0.x, r2, s4
mad r2.xyz, v4, r2.w, c4
mov_pp r0.y, r0.x
texld r0.x, r2, s4
mov r2.y, c3.x
add r2.y, c16.w, -r2
mad r0, r0, r2.y, c3.x
dp4_pp r0.y, r0, c21.w
rcp r0.x, v3.w
mad r4.xy, v3, r0.x, c21.y
dp4 r2.x, c2, c2
rsq r2.x, r2.x
mul r2.xyz, r2.x, c2
dp3_pp r0.z, v2, -r2
mul_pp r3.xyz, v2, r0.z
mad_pp r3.xyz, -r3, c18.z, -r2
dp3 r0.x, v3, v3
texld r0.w, r4, s2
cmp r0.z, -v3, c17.x, c17.y
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.z, r0
mul_pp r2.w, r0.x, r0.y
mul r0.xyz, r2.w, c8
dp3_pp_sat r3.w, v1, r3
mul r3.xyz, r0, c9
pow_pp r0, r3.w, c11.x
dp3_pp_sat r0.w, v2, r2
add_pp r2.x, r0.w, c16.w
frc_pp r2.y, r2.x
add_pp r0.w, r0, c21.z
add_pp_sat r2.x, r2, -r2.y
mul r0.xyz, r3, r0.x
mul r0.xyz, r2.x, r0
mul_pp r0.w, r0, c8
mul r0.xyz, r1.w, r0
mul_pp r1.w, r0, r2
mov r0.w, c14.x
mul_pp r1.xyz, r1, c10
mul_pp_sat r1.w, r1, c22.x
add r2.xyz, c8, r0.w
mad_sat r2.xyz, r2, r1.w, c0
add_pp r0.xyz, r2, r0
mul_pp oC0.xyz, r1, r0
texldp r0.x, v6, s5
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c16, c16.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c16
mul_sat r0.y, r0, c15.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c16.y
mad oC0.w, r0.x, r0.y, r0.z
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

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightPositionRange]
Vector 4 [_LightShadowData]
Vector 5 [_LightColor0]
Vector 6 [_SpecColor]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_CameraDepthTexture] 2D
"ps_3_0
; 133 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
def c13, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.00781250
def c19, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c20, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c21, 4.03944778, 0, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r1.xy, v5, c9.x
dsx r3.zw, v5.xyxy
abs r0.w, v5.z
abs r2.xy, v5
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mad r0.x, r2.z, c16.y, c16.z
mad r0.x, r0, r2.z, c16.w
mad r2.w, r0.x, r2.z, c17.x
mul r0.xy, v5.zyzw, c9.x
mul r3.zw, r3, r3
mad r2.w, r2, r2.z, c17.y
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c17
mul r1.w, r0.z, r1
mul r0.xy, v5.zxzw, c9.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
abs r2.y, v5
add r2.w, -r2.y, c13
rsq r2.w, r2.w
add r2.x, r2, -r0.w
add r2.z, -r1.w, c17.w
cmp r1.w, -r2.x, r1, r2.z
add r2.x, -r1.w, c15.w
cmp r1.w, v5.z, r1, r2.x
cmp r1.w, v5.x, r1, -r1
mad r3.x, r1.w, c18, c18.y
mad r1.w, r0, c14.z, c14
mad r2.z, r2.y, c14, c14.w
mad r2.z, r2, r2.y, c15.x
mul r2.x, v0, c10
mad r1.w, r0, r1, c15.x
mad r2.y, r2.z, r2, c15
rcp r2.w, r2.w
mul r2.z, r2.y, r2.w
cmp r2.y, v5, c14.x, c14
mul r2.w, r2.y, r2.z
add_pp r1.xyz, -r0, c13.w
mul_sat r2.x, r2, c15.z
mad_pp r1.xyz, r2.x, r1, r0
add r2.x, -r0.w, c13.w
rsq r2.x, r2.x
mad r0.w, r0, r1, c15.y
rcp r2.x, r2.x
mul r1.w, r0, r2.x
cmp r0.w, v5.z, c14.x, c14.y
mul r2.x, r0.w, r1.w
mad r2.x, -r2, c15.z, r1.w
mad r1.w, -r2, c15.z, r2.z
mad r2.x, r0.w, c15.w, r2
mad r0.w, r2.y, c15, r1
mul r1.w, r2.x, c16.x
mul r3.y, r0.w, c16.x
add r0.w, r3.z, r3
dsy r2.xz, v5.xyyw
rsq r0.w, r0.w
mul r2.xz, r2, r2
dsx r2.w, r1
dsy r2.y, r1.w
add r1.w, r2.x, r2.z
rcp r0.w, r0.w
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.z, r0.w, c18.x
mul r2.x, r1.w, c18
texldd r2, r3, s0, r2.zwzw, r2
mul_pp r2.xyz, r2, r1
add r0.xyz, v4, c19.xyyw
texld r0, r0, s2
dp4 r3.w, r0, c20
add r0.xyz, v4, c19.yxyw
texld r0, r0, s2
dp4 r3.z, r0, c20
add r1.xyz, v4, c19.yyxw
texld r1, r1, s2
dp4 r3.y, r1, c20
dp3 r0.w, v4, v4
rsq r1.x, r0.w
add r0.xyz, v4, c18.w
texld r0, r0, s2
dp4 r3.x, r0, c20
rcp r1.x, r1.x
mul r0.x, r1, c3.w
dp4 r1.x, c2, c2
mad r0, -r0.x, c19.z, r3
mov r1.y, c4.x
cmp r0, r0, c13.w, r1.y
dp4_pp r0.y, r0, c19.w
rsq r1.x, r1.x
mul r1.xyz, r1.x, c2
dp3_pp r0.z, v2, -r1
mul_pp r3.xyz, v2, r0.z
mad_pp r3.xyz, -r3, c15.z, -r1
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
mul r1.w, r0.x, r0.y
mul r0.xyz, r1.w, c5
dp3_pp_sat r3.w, v1, r3
mul r3.xyz, r0, c6
pow_pp r0, r3.w, c8.x
dp3_pp_sat r0.w, v2, r1
add_pp r1.x, r0.w, c13.w
frc_pp r1.y, r1.x
add_pp r0.w, r0, c18.z
add_pp_sat r1.x, r1, -r1.y
mul r0.xyz, r3, r0.x
mul r0.xyz, r1.x, r0
mul_pp r0.w, r0, c5
mul_pp r1.x, r0.w, r1.w
mul_pp_sat r1.w, r1.x, c21.x
mov r0.w, c11.x
add r1.xyz, c5, r0.w
mad_sat r1.xyz, r1, r1.w, c0
mul r0.xyz, r2.w, r0
add_pp r0.xyz, r1, r0
mul_pp r1.xyz, r2, c7
mul_pp oC0.xyz, r1, r0
texldp r0.x, v6, s4
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c13, c13.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c13
mul_sat r0.y, r0, c12.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c13.y
mad oC0.w, r0.x, r0.y, r0.z
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

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightPositionRange]
Vector 4 [_LightShadowData]
Vector 5 [_LightColor0]
Vector 6 [_SpecColor]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_Clarity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
SetTexture 5 [_CameraDepthTexture] 2D
"ps_3_0
; 134 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c13, -600.00000000, 0.00200000, 0.75000000, 1.00000000
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.00781250
def c19, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c20, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c21, 4.03944778, 0, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r1.xy, v5, c9.x
dsx r3.zw, v5.xyxy
abs r0.w, v5.z
abs r2.xy, v5
max r0.x, r2, r0.w
rcp r0.y, r0.x
min r0.x, r2, r0.w
mul r1.w, r0.x, r0.y
mul r2.z, r1.w, r1.w
mad r0.x, r2.z, c16.y, c16.z
mad r0.x, r0, r2.z, c16.w
mad r2.w, r0.x, r2.z, c17.x
mul r0.xy, v5.zyzw, c9.x
mul r3.zw, r3, r3
mad r2.w, r2, r2.z, c17.y
texld r1.xyz, r1, s1
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r1.xyz, r2.x, r0, r1
mad r0.z, r2.w, r2, c17
mul r1.w, r0.z, r1
mul r0.xy, v5.zxzw, c9.x
texld r0.xyz, r0, s1
add_pp r0.xyz, r0, -r1
mad_pp r0.xyz, r2.y, r0, r1
add_pp r1.xyz, -r0, c13.w
add r2.x, r2, -r0.w
add r2.z, -r1.w, c17.w
cmp r1.w, -r2.x, r1, r2.z
add r2.x, -r1.w, c15.w
cmp r1.w, v5.z, r1, r2.x
cmp r1.w, v5.x, r1, -r1
mul r2.x, v0, c10
mul_sat r2.x, r2, c15.z
mad_pp r2.xyz, r2.x, r1, r0
abs r1.z, v5.y
mad r3.x, r1.w, c18, c18.y
add r1.y, -r0.w, c13.w
mad r1.x, r0.w, c14.z, c14.w
mad r1.x, r0.w, r1, c15
add r2.w, -r1.z, c13
mad r1.w, r1.z, c14.z, c14
mad r1.w, r1, r1.z, c15.x
rsq r1.y, r1.y
rsq r2.w, r2.w
mad r0.w, r0, r1.x, c15.y
rcp r1.y, r1.y
mul r1.x, r0.w, r1.y
cmp r0.w, v5.z, c14.x, c14.y
mul r1.y, r0.w, r1.x
mad r1.y, -r1, c15.z, r1.x
mad r1.z, r1.w, r1, c15.y
rcp r2.w, r2.w
mul r1.w, r1.z, r2
cmp r1.z, v5.y, c14.x, c14.y
mul r2.w, r1.z, r1
mad r1.x, -r2.w, c15.z, r1.w
mad r1.y, r0.w, c15.w, r1
mad r0.w, r1.z, c15, r1.x
mul r1.x, r1.y, c16
mul r3.y, r0.w, c16.x
add r0.w, r3.z, r3
rsq r0.w, r0.w
dsx r1.w, r1.x
dsy r1.y, r1.x
dsy r1.xz, v5.xyyw
mul r1.xz, r1, r1
add r1.x, r1, r1.z
rcp r0.w, r0.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.z, r0.w, c18.x
add r0.xyz, v4, c19.xyyw
texld r0, r0, s2
dp4 r3.w, r0, c20
mul r1.x, r1, c18
texldd r1, r3, s0, r1.zwzw, r1
mul_pp r1.xyz, r1, r2
add r0.xyz, v4, c19.yxyw
texld r0, r0, s2
dp4 r3.z, r0, c20
add r2.xyz, v4, c19.yyxw
texld r2, r2, s2
dp4 r3.y, r2, c20
add r0.xyz, v4, c18.w
texld r0, r0, s2
dp3 r2.x, v4, v4
dp4 r3.x, r0, c20
rsq r2.x, r2.x
rcp r0.x, r2.x
dp4 r2.x, c2, c2
mul r0.x, r0, c3.w
rsq r2.x, r2.x
mul r2.xyz, r2.x, c2
mad r0, -r0.x, c19.z, r3
mov r2.w, c4.x
cmp r0, r0, c13.w, r2.w
dp4_pp r0.y, r0, c19.w
dp3_pp r2.w, v2, -r2
mul_pp r3.xyz, v2, r2.w
mad_pp r3.xyz, -r3, c15.z, -r2
dp3 r0.x, v3, v3
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul r2.w, r0.x, r0.y
mul r0.xyz, r2.w, c5
dp3_pp_sat r3.w, v1, r3
mul r3.xyz, r0, c6
pow_pp r0, r3.w, c8.x
dp3_pp_sat r0.w, v2, r2
add_pp r2.x, r0.w, c13.w
frc_pp r2.y, r2.x
add_pp r0.w, r0, c18.z
add_pp_sat r2.x, r2, -r2.y
mul r0.xyz, r3, r0.x
mul r0.xyz, r2.x, r0
mul_pp r0.w, r0, c5
mul r0.xyz, r1.w, r0
mul_pp r1.w, r0, r2
mov r0.w, c11.x
mul_pp r1.xyz, r1, c7
mul_pp_sat r1.w, r1, c21.x
add r2.xyz, c5, r0.w
mad_sat r2.xyz, r2, r1.w, c0
add_pp r0.xyz, r2, r0
mul_pp oC0.xyz, r1, r0
texldp r0.x, v6, s5
mov r1.xyz, v2
dp3 r0.y, v1, r1
mad r0.x, r0, c1.z, c1.w
mad r0.z, -r0.y, c13, c13.w
rcp r0.x, r0.x
add r0.y, r0.x, -v6.z
add r0.x, v0, c13
mul_sat r0.y, r0, c12.x
add r0.y, r0, -r0.z
mul_sat r0.x, r0, c13.y
mad oC0.w, r0.x, r0.y, r0.z
"
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

#LINE 162

	
		}
		
		Pass {
            Tags {"LightMode" = "ForwardAdd"} 
            Blend One One                                      
            Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 10 to 19
//   d3d9 - ALU: 12 to 21
//   d3d11 - ALU: 8 to 17, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 8 to 17, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Vector 17 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 18 [unity_Scale]
Matrix 13 [_LightMatrix0]
"!!ARBvp1.0
# 18 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MOV R1, c[17];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD result.texcoord[2].xyz, R0, c[18].w, -vertex.position;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV result.texcoord[5], vertex.color;
MOV result.texcoord[1].xyz, vertex.normal;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
Matrix 12 [_LightMatrix0]
"vs_2_0
; 20 ALU
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
mov r0, c10
dp4 r2.z, c16, r0
mov r0, c9
dp4 r2.y, c16, r0
mov r1, c8
dp4 r2.x, c16, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mad oT2.xyz, r2, c17.w, -v0
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT5, v1
mov oT1.xyz, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmjjpegplcgemohadockdciemelndpjpbabaaaaaaoiaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadapaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmadaaaaeaaaabaa
nlaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegbcbaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaaeaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaafaaaaaaegbobaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz);
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4)).w;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (tmpvar_5 * 2.0));
  c_1.xyz = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_8;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz);
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_LightTexture0, vec2(tmpvar_4)).w;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (tmpvar_5 * 2.0));
  c_1.xyz = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_8;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
Matrix 12 [_LightMatrix0]
"agal_vs
[bc]
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaacaaaeacbaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r2.z, c16, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaacaaacacbaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r2.y, c16, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaacaaabacbaaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r2.x, c16, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
adaaaaaaabaaahacacaaaakeacaaaaaabbaaaappabaaaaaa mul r1.xyz, r2.xyzz, c17.w
acaaaaaaacaaahaeabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub v2.xyz, r1.xyzz, a0
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v3.z, r0, c14
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
aaaaaaaaafaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v5, a2
aaaaaaaaabaaahaeabaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, a1
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedakhailhlejdgcnafjjmlpemddlfdopddabaaaaaaaaahaaaaaeaaaaaa
daaaaaaaeeacaaaaliafaaaaeiagaaaaebgpgodjamacaaaaamacaaaaaaacpopp
leabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaabaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaajaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaapia
afaaoekaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabbaaoekaaaaappiaaaaaoeiaaeaaaaaeabaaahoaaaaaoeiabcaappka
aaaaoejbafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoeka
aeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoeka
aaaakkiaabaaoeiaaeaaaaaeadaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaahoaacaaoejaabaaaaacaeaaapoaabaaoeja
ppppaaaafdeieefcgmadaaaaeaaaabaanlaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaapgipcaaa
abaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaa
aaaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadgaaaaaf
hccabaaaadaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafpccabaaaafaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheoiiaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaafeeb
eoehefeofeaaklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT" }
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
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec3 _LightCoord;
    highp vec4 color;
};
#line 317
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
#line 335
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 348
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 335
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 339
    o.lightDir = ObjSpaceLightDir( v.vertex);
    o.color = v.color;
    o.normal = v.normal;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 344
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD3;
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
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval.color);
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
#line 325
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec3 _LightCoord;
    highp vec4 color;
};
#line 317
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
#line 335
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 348
#line 348
lowp vec4 frag( in v2f IN ) {
    IN.lightDir = normalize(IN.lightDir);
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0);
    #line 352
    lowp vec3 normal = IN.normal;
    lowp float diff = xll_saturate_f(dot( normal, IN.lightDir));
    lowp vec4 c;
    c.xyz = (((IN.color.xyz * _LightColor0.xyz) * diff) * (atten * 2.0));
    #line 356
    c.w = IN.color.w;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN.color = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Vector 9 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
"!!ARBvp1.0
# 10 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MOV R0, c[9];
DP4 result.texcoord[2].z, R0, c[7];
DP4 result.texcoord[2].y, R0, c[6];
DP4 result.texcoord[2].x, R0, c[5];
MOV result.texcoord[5], vertex.color;
MOV result.texcoord[1].xyz, vertex.normal;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
"vs_2_0
; 12 ALU
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
mov r0, c6
dp4 oT2.z, c8, r0
mov r0, c5
mov r1, c4
dp4 oT2.y, c8, r0
dp4 oT2.x, c8, r1
mov oT5, v1
mov oT1.xyz, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhlffamgibkghgdhcndobnoaidcnlmladabaaaaaafiadaaaaadaaaaaa
cmaaaaaalmaaaaaafmabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadapaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
peabaaaaeaaaabaahnaaaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaae
egiocaaaabaaaaaabeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaaaaaaaaegiccaaa
abaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabaaaaaaa
agiacaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegiccaaaabaaaaaabdaaaaaapgipcaaaaaaaaaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegbcbaaaacaaaaaa
dgaaaaafpccabaaaaeaaaaaaegbobaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (_World2Object * _WorldSpaceLightPos0).xyz;
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * 2.0);
  c_1.xyz = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_6;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (_World2Object * _WorldSpaceLightPos0).xyz;
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * 2.0);
  c_1.xyz = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_6;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
"agal_vs
[bc]
aaaaaaaaaaaaapacagaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c6
bdaaaaaaacaaaeaeaiaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 v2.z, c8, r0
aaaaaaaaaaaaapacafaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c5
aaaaaaaaabaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c4
bdaaaaaaacaaacaeaiaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 v2.y, c8, r0
bdaaaaaaacaaabaeaiaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 v2.x, c8, r1
aaaaaaaaafaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v5, a2
aaaaaaaaabaaahaeabaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, a1
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedjnmaggkionlfmiffnkeilonkceebjlmlabaaaaaaliaeaaaaaeaaaaaa
daaaaaaaimabaaaaiiadaaaabiaeaaaaebgpgodjfeabaaaafeabaaaaaaacpopp
aiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaaaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaabaaaaeaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjaabaaaaacaaaaapiaabaaoekaafaaaaadabaaahia
aaaaffiaahaaoekaaeaaaaaeabaaahiaagaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaakkiaabaaoeiaaeaaaaaeabaaahoaajaaoekaaaaappia
aaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaahoaacaaoejaabaaaaac
adaaapoaabaaoejappppaaaafdeieefcpeabaaaaeaaaabaahnaaaaaafjaaaaae
egiocaaaaaaaaaaaabaaaaaafjaaaaaeegiocaaaabaaaaaabeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaaaaaaaaegiccaaaabaaaaaabbaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaabaaaaaabaaaaaaaagiacaaaaaaaaaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabcaaaaaakgikcaaa
aaaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegiccaaa
abaaaaaabdaaaaaapgipcaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaadaaaaaaegbcbaaaacaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaa
abaaaaaadoaaaaabejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
hoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafaepfdejfeejepeo
aaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadapaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
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
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec4 color;
};
#line 315
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
#line 332
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 344
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 332
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 336
    o.lightDir = ObjSpaceLightDir( v.vertex);
    o.color = v.color;
    o.normal = v.normal;
    #line 340
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD1;
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
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD5 = vec4(xl_retval.color);
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
#line 323
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec4 color;
};
#line 315
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
#line 332
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 344
#line 344
lowp vec4 frag( in v2f IN ) {
    IN.lightDir = normalize(IN.lightDir);
    lowp float atten = 1.0;
    #line 348
    lowp vec3 normal = IN.normal;
    lowp float diff = xll_saturate_f(dot( normal, IN.lightDir));
    lowp vec4 c;
    c.xyz = (((IN.color.xyz * _LightColor0.xyz) * diff) * (atten * 2.0));
    #line 352
    c.w = IN.color.w;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.color = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Vector 17 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 18 [unity_Scale]
Matrix 13 [_LightMatrix0]
"!!ARBvp1.0
# 19 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MOV R1, c[17];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD result.texcoord[2].xyz, R0, c[18].w, -vertex.position;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV result.texcoord[5], vertex.color;
MOV result.texcoord[1].xyz, vertex.normal;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
Matrix 12 [_LightMatrix0]
"vs_2_0
; 21 ALU
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
mov r0, c10
dp4 r2.z, c16, r0
mov r0, c9
dp4 r2.y, c16, r0
mov r1, c8
dp4 r2.x, c16, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mad oT2.xyz, r2, c17.w, -v0
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT5, v1
mov oT1.xyz, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddiemkimndippbbnjeipihbehkfmhcbkpabaaaaaaoiaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadapaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmadaaaaeaaaabaa
nlaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegbcbaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaaaaaaaaaaeaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaafaaaaaaegbobaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz);
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  lowp float atten_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_5 = texture2D (_LightTexture0, P_6);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2(tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_5.w) * tmpvar_8.w);
  atten_4 = tmpvar_9;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (atten_4 * 2.0));
  c_1.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_12;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz);
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  lowp float atten_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_5 = texture2D (_LightTexture0, P_6);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2(tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_5.w) * tmpvar_8.w);
  atten_4 = tmpvar_9;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (atten_4 * 2.0));
  c_1.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_12;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
Matrix 12 [_LightMatrix0]
"agal_vs
[bc]
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaacaaaeacbaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r2.z, c16, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaacaaacacbaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r2.y, c16, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaacaaabacbaaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r2.x, c16, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
adaaaaaaabaaahacacaaaakeacaaaaaabbaaaappabaaaaaa mul r1.xyz, r2.xyzz, c17.w
acaaaaaaacaaahaeabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub v2.xyz, r1.xyzz, a0
bdaaaaaaadaaaiaeaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 v3.w, r0, c15
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v3.z, r0, c14
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
aaaaaaaaafaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v5, a2
aaaaaaaaabaaahaeabaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, a1
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedeikidmidnabnlgbjbikkomfoibegjdckabaaaaaaaaahaaaaaeaaaaaa
daaaaaaaeeacaaaaliafaaaaeiagaaaaebgpgodjamacaaaaamacaaaaaaacpopp
leabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaabaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaajaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaapia
afaaoekaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabbaaoekaaaaappiaaaaaoeiaaeaaaaaeabaaahoaaaaaoeiabcaappka
aaaaoejbafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoeka
aeaaaaaeabaaapiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoeka
aaaakkiaabaaoeiaaeaaaaaeadaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaad
aaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaahoaacaaoejaabaaaaacaeaaapoaabaaoeja
ppppaaaafdeieefcgmadaaaaeaaaabaanlaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaapgipcaaa
abaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaa
aaaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadgaaaaaf
hccabaaaadaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aeaaaaaaegiocaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaafaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheoiiaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaafeeb
eoehefeofeaaklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
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
#line 334
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec4 _LightCoord;
    highp vec4 color;
};
#line 326
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
#line 344
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 357
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 344
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 348
    o.lightDir = ObjSpaceLightDir( v.vertex);
    o.color = v.color;
    o.normal = v.normal;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 353
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD3;
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
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval.color);
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
#line 334
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec4 _LightCoord;
    highp vec4 color;
};
#line 326
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
#line 344
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 357
#line 322
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 324
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 318
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 320
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 357
lowp vec4 frag( in v2f IN ) {
    IN.lightDir = normalize(IN.lightDir);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0);
    #line 361
    lowp vec3 normal = IN.normal;
    lowp float diff = xll_saturate_f(dot( normal, IN.lightDir));
    lowp vec4 c;
    c.xyz = (((IN.color.xyz * _LightColor0.xyz) * diff) * (atten * 2.0));
    #line 365
    c.w = IN.color.w;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN.color = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Vector 17 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 18 [unity_Scale]
Matrix 13 [_LightMatrix0]
"!!ARBvp1.0
# 18 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MOV R1, c[17];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD result.texcoord[2].xyz, R0, c[18].w, -vertex.position;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV result.texcoord[5], vertex.color;
MOV result.texcoord[1].xyz, vertex.normal;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
Matrix 12 [_LightMatrix0]
"vs_2_0
; 20 ALU
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
mov r0, c10
dp4 r2.z, c16, r0
mov r0, c9
dp4 r2.y, c16, r0
mov r1, c8
dp4 r2.x, c16, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mad oT2.xyz, r2, c17.w, -v0
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT5, v1
mov oT1.xyz, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmjjpegplcgemohadockdciemelndpjpbabaaaaaaoiaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadapaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgmadaaaaeaaaabaa
nlaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegbcbaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaaeaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaafaaaaaaegbobaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz);
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_5;
  tmpvar_5 = (texture2D (_LightTextureB0, vec2(tmpvar_4)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (tmpvar_5 * 2.0));
  c_1.xyz = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_8;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz);
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_5;
  tmpvar_5 = (texture2D (_LightTextureB0, vec2(tmpvar_4)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (tmpvar_5 * 2.0));
  c_1.xyz = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_8;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
Matrix 12 [_LightMatrix0]
"agal_vs
[bc]
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaacaaaeacbaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r2.z, c16, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaacaaacacbaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r2.y, c16, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaacaaabacbaaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r2.x, c16, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
adaaaaaaabaaahacacaaaakeacaaaaaabbaaaappabaaaaaa mul r1.xyz, r2.xyzz, c17.w
acaaaaaaacaaahaeabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub v2.xyz, r1.xyzz, a0
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v3.z, r0, c14
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
aaaaaaaaafaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v5, a2
aaaaaaaaabaaahaeabaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, a1
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedakhailhlejdgcnafjjmlpemddlfdopddabaaaaaaaaahaaaaaeaaaaaa
daaaaaaaeeacaaaaliafaaaaeiagaaaaebgpgodjamacaaaaamacaaaaaaacpopp
leabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaabaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaajaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaapia
afaaoekaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabbaaoekaaaaappiaaaaaoeiaaeaaaaaeabaaahoaaaaaoeiabcaappka
aaaaoejbafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoeka
aeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoeka
aaaakkiaabaaoeiaaeaaaaaeadaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaahoaacaaoejaabaaaaacaeaaapoaabaaoeja
ppppaaaafdeieefcgmadaaaaeaaaabaanlaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaaaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaapgipcaaa
abaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaa
aaaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadgaaaaaf
hccabaaaadaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafpccabaaaafaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheoiiaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaafeeb
eoehefeofeaaklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
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
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec3 _LightCoord;
    highp vec4 color;
};
#line 318
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
#line 336
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 349
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 336
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 340
    o.lightDir = ObjSpaceLightDir( v.vertex);
    o.color = v.color;
    o.normal = v.normal;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 345
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD3;
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
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval.color);
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
#line 326
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec3 _LightCoord;
    highp vec4 color;
};
#line 318
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
#line 336
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 349
#line 349
lowp vec4 frag( in v2f IN ) {
    IN.lightDir = normalize(IN.lightDir);
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0);
    #line 353
    lowp vec3 normal = IN.normal;
    lowp float diff = xll_saturate_f(dot( normal, IN.lightDir));
    lowp vec4 c;
    c.xyz = (((IN.color.xyz * _LightColor0.xyz) * diff) * (atten * 2.0));
    #line 357
    c.w = IN.color.w;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN.color = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Vector 17 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
"!!ARBvp1.0
# 16 ALU
PARAM c[18] = { program.local[0],
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
MOV R0, c[17];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV result.texcoord[5], vertex.color;
MOV result.texcoord[1].xyz, vertex.normal;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
"vs_2_0
; 18 ALU
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
mov r0, c10
dp4 oT2.z, c16, r0
mov r0, c9
dp4 oT2.y, c16, r0
mov r1, c8
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT2.x, c16, r1
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT5, v1
mov oT1.xyz, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 19 instructions, 2 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddmhacdconjpjameeinopjabeejblfbnhabaaaaaalmaeaaaaadaaaaaa
cmaaaaaalmaaaaaaheabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeebeoehefeofeaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceaadaaaaeaaaabaa
naaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaaacaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaadaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiacaaaaaaaaaaaacaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaak
mccabaaaabaaaaaaagiecaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaagaebaaa
aaaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (_World2Object * _WorldSpaceLightPos0).xyz;
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_5;
  tmpvar_5 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (tmpvar_4 * 2.0));
  c_1.xyz = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_7;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = (_World2Object * _WorldSpaceLightPos0).xyz;
  xlv_TEXCOORD1 = normalize(_glesNormal);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD5 = _glesColor;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
void main ()
{
  lowp vec4 c_1;
  lowp float diff_2;
  lowp vec3 normal_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  normal_3 = xlv_TEXCOORD1;
  highp float tmpvar_5;
  tmpvar_5 = clamp (dot (normal_3, normalize(xlv_TEXCOORD2)), 0.0, 1.0);
  diff_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((xlv_TEXCOORD5.xyz * _LightColor0.xyz) * diff_2) * (tmpvar_4 * 2.0));
  c_1.xyz = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD5.w;
  c_1.w = tmpvar_7;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
"agal_vs
[bc]
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaacaaaeaebaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 v2.z, c16, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaacaaacaebaaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 v2.y, c16, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaacaaabaebaaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 v2.x, c16, r1
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
aaaaaaaaafaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v5, a2
aaaaaaaaabaaahaeabaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, a1
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 80 used size, 4 vars
Matrix 16 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 19 instructions, 2 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedfdghapkdldpokkagfeafamaifeehnmmfabaaaaaamaagaaaaaeaaaaaa
daaaaaaadaacaaaahiafaaaaaiagaaaaebgpgodjpiabaaaapiabaaaaaaacpopp
kaabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaabaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaiaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaapia
afaaoekaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaakkiaabaaoeiaaeaaaaae
abaaahoabbaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoeka
aeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaad
abaaadiaaaaaffiaacaaobkaaeaaaaaeaaaaadiaabaaobkaaaaaaaiaabaaoeia
aeaaaaaeaaaaadiaadaaobkaaaaakkiaaaaaoeiaaeaaaaaeaaaaamoaaeaabeka
aaaappiaaaaaeeiaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapia
agaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaahoaacaaoeja
abaaaaacadaaapoaabaaoejappppaaaafdeieefceaadaaaaeaaaabaanaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaadaaaaaaegbcbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaacaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaa
abaaaaaaagiecaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaa
dgaaaaafpccabaaaaeaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheoiiaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaafeeb
eoehefeofeaaklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadapaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
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
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec2 _LightCoord;
    highp vec4 color;
};
#line 317
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
#line 335
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 348
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 335
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 339
    o.lightDir = ObjSpaceLightDir( v.vertex);
    o.color = v.color;
    o.normal = v.normal;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 344
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD3;
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
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec4(xl_retval.color);
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
#line 325
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 lightDir;
    highp vec3 normal;
    highp vec2 _LightCoord;
    highp vec4 color;
};
#line 317
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
#line 335
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
#line 348
#line 348
lowp vec4 frag( in v2f IN ) {
    IN.lightDir = normalize(IN.lightDir);
    lowp float atten = (texture( _LightTexture0, IN._LightCoord).w * 1.0);
    #line 352
    lowp vec3 normal = IN.normal;
    lowp float diff = xll_saturate_f(dot( normal, IN.lightDir));
    lowp vec4 c;
    c.xyz = (((IN.color.xyz * _LightColor0.xyz) * diff) * (atten * 2.0));
    #line 356
    c.w = IN.color.w;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xlt_IN.color = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 8 to 17, TEX: 0 to 2
//   d3d9 - ALU: 9 to 17, TEX: 1 to 2
//   d3d11 - ALU: 7 to 14, TEX: 0 to 2, FLOW: 1 to 1
//   d3d11_9x - ALU: 7 to 14, TEX: 0 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
"!!ARBfp1.0
# 11 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 2 } };
TEMP R0;
TEMP R1;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MOV result.color.w, fragment.texcoord[5];
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[2];
MUL R0.xyz, fragment.texcoord[5], c[0];
DP3_SAT R1.x, fragment.texcoord[1], R1;
MUL R0.w, R0, c[1].x;
MUL R0.xyz, R0, R1.x;
MUL result.color.xyz, R0, R0.w;
END
# 11 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
"ps_2_0
; 12 ALU, 1 TEX
dcl_2d s0
def c1, 2.00000000, 0, 0, 0
dcl t2.xyz
dcl t1.xyz
dcl t3.xyz
dcl t5
dp3 r0.x, t3, t3
mov r0.xy, r0.x
dp3 r1.x, t2, t2
rsq r1.x, r1.x
mul r1.xyz, r1.x, t2
dp3_pp_sat r1.x, t1, r1
mul r2.xyz, t5, c0
mul r1.xyz, r2, r1.x
texld r0, r0, s0
mul_pp r0.x, r0, c1
mul r0.xyz, r1, r0.x
mov_pp r0.w, t5
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 12 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbioionpndiclbpbkjhaodjppefcaogpfabaaaaaammacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmabaaaa
eaaaaaaaglaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaabacaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaaaaaaaaaaaagaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaapgapbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkbabaaaafaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
"agal_ps
c1 2.0 0.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaacaaahacafaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, v5, c0
ciaaaaaaaaaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r0, r0.xyyy, s0 <2d wrap linear point>
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r0.x, v2
adaaaaaaaaaaabacaaaaaappacaaaaaaabaaaaoeabaaaaaa mul r0.x, r0.w, c1
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
bgaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r1.x, r1.x
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r1.xyzz, r0.x
aaaaaaaaaaaaaiacafaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.w, v5
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 12 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedalemgnichmemlepajpfbeadidmiehekdabaaaaaapaadaaaaaeaaaaaa
daaaaaaafaabaaaaaeadaaaalmadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
oeaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaacpla
bpaaaaacaaaaaajaaaaiapkaceaaaaacaaaaahiaabaaoelaaiaaaaadaaaadbia
acaaoelaaaaaoeiaafaaaaadaaaaaoiaaeaabllaaaaablkaafaaaaadaaaaahia
aaaaaaiaaaaabliaaiaaaaadaaaaaiiaadaaoelaadaaoelaabaaaaacabaaadia
aaaappiaecaaaaadabaacpiaabaaoeiaaaaioekaacaaaaadaaaaaiiaabaaaaia
abaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciiaaeaappla
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckmabaaaaeaaaaaaaglaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaabacaaaah
bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagbjbaaaafaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkbabaaaafaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
"!!ARBfp1.0
# 8 ALU, 0 TEX
PARAM c[2] = { program.local[0],
		{ 2 } };
TEMP R0;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3_SAT R0.w, fragment.texcoord[1], R0;
MUL R0.xyz, fragment.texcoord[5], c[0];
MUL R0.xyz, R0, R0.w;
MUL result.color.xyz, R0, c[1].x;
MOV result.color.w, fragment.texcoord[5];
END
# 8 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
"ps_2_0
; 9 ALU
def c1, 2.00000000, 0, 0, 0
dcl t2.xyz
dcl t1.xyz
dcl t5
dp3 r0.x, t2, t2
rsq r0.x, r0.x
mul r0.xyz, r0.x, t2
dp3_pp_sat r0.x, t1, r0
mul r1.xyz, t5, c0
mul r0.xyz, r1, r0.x
mul r0.xyz, r0, c1.x
mov_pp r0.w, t5
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 48 // 48 used size, 3 vars
Vector 32 [_LightColor0] 4
BindCB "$Globals" 0
// 9 instructions, 1 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedloieipnbkbffnjnmagdbeekmebefinkdabaaaaaadaacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcciabaaaaeaaaaaaaekaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaabacaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagbjbaaaaeaaaaaaagijcaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkbabaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
"agal_ps
c1 2.0 0.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v1, r0.xyzz
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaabaaahacafaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, v5, c0
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r1.xyzz, r0.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c1.x
aaaaaaaaaaaaaiacafaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.w, v5
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 48 // 48 used size, 3 vars
Vector 32 [_LightColor0] 4
BindCB "$Globals" 0
// 9 instructions, 1 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedhmbgndkhekjafmbnlllfoeplpaliaonaabaaaaaapmacaaaaaeaaaaaa
daaaaaaapiaaaaaaciacaaaamiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jaaaaaaadaaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaaaaadaaaaaaaacaa
abaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaacplaceaaaaacaaaaahiaabaaoelaaiaaaaad
aaaadbiaacaaoelaaaaaoeiaafaaaaadaaaaaoiaadaabllaaaaablkaafaaaaad
aaaaahiaaaaaaaiaaaaabliaacaaaaadaaaachiaaaaaoeiaaaaaoeiaabaaaaac
aaaaciiaadaapplaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcciabaaaa
eaaaaaaaekaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaabacaaaah
bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagbjbaaaaeaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkbabaaa
aeaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaafaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"!!ARBfp1.0
# 17 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[1].y;
SLT R2.x, c[1], fragment.texcoord[3].z;
MOV result.color.w, fragment.texcoord[5];
TEX R0.w, R0, texture[0], 2D;
TEX R1.w, R0.z, texture[1], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.x, R0.x;
MUL R0.w, R2.x, R0;
MUL R1.xyz, R1.x, fragment.texcoord[2];
MUL R1.w, R0, R1;
DP3_SAT R0.w, fragment.texcoord[1], R1;
MUL R0.xyz, fragment.texcoord[5], c[0];
MUL R1.x, R1.w, c[1].z;
MUL R0.xyz, R0, R0.w;
MUL result.color.xyz, R0, R1.x;
END
# 17 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t2.xyz
dcl t1.xyz
dcl t3
dcl t5
rcp r1.x, t3.w
mad r2.xy, t3, r1.x, c1.x
dp3 r0.x, t3, t3
mov r1.xy, r0.x
texld r0, r2, s0
texld r2, r1, s1
cmp r0.x, -t3.z, c1.y, c1.z
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r2
dp3 r1.x, t2, t2
rsq r1.x, r1.x
mul r1.xyz, r1.x, t2
mul_pp r0.x, r0, c1.w
dp3_pp_sat r1.x, t1, r1
mul r2.xyz, t5, c0
mul r1.xyz, r2, r1.x
mul r0.xyz, r1, r0.x
mov_pp r0.w, t5
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 1 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednbeijpebpeecdfmohlgldkeeefgcibieabaaaaaakeadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieacaaaa
eaaaaaaakbaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaa
aaaaaaaaagaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaabacaaaahccaabaaa
aaaaaaaaegbcbaaaadaaaaaajgahbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkbabaaaafaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"agal_ps
c1 0.5 0.0 1.0 2.0
[bc]
afaaaaaaabaaabacadaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v3.w
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
adaaaaaaabaaadacadaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v3, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaaaaabaaaaaa add r1.xy, r1.xyyy, c1.x
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaacaaahacafaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, v5, c0
ciaaaaaaabaaapacabaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r1.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
bfaaaaaaacaaaiacadaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r2.w, v3.z
ckaaaaaaaaaaabacacaaaappacaaaaaaabaaaaffabaaaaaa slt r0.x, r2.w, c1.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
bgaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r1.x, r1.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappabaaaaaa mul r0.x, r0.x, c1.w
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r1.xyzz, r0.x
aaaaaaaaaaaaaiacafaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.w, v5
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 1 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecediebbibeaffknnoffjkdbkppjakhalgobabaaaaaaeeafaaaaaeaaaaaa
daaaaaaammabaaaafiaeaaaabaafaaaaebgpgodjjeabaaaajeabaaaaaaacpppp
fmabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaagaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaaiaaeaacplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaadaappla
aeaaaaaeaaaaadiaadaaoelaaaaappiaabaaaakaaiaaaaadabaaaiiaadaaoela
adaaoelaabaaaaacabaaadiaabaappiaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaabaaoeiaabaioekaafaaaaadaaaacbiaaaaappiaabaaaaia
fiaaaaaeaaaacbiaadaakklbabaaffkaaaaaaaiaacaaaaadaaaaabiaaaaaaaia
aaaaaaiaceaaaaacabaaahiaabaaoelaaiaaaaadaaaadciaacaaoelaabaaoeia
afaaaaadabaaahiaaeaaoelaaaaaoekaafaaaaadaaaaaoiaaaaaffiaabaablia
afaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaaeaapplaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcieacaaaaeaaaaaaakbaaaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaa
aeaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaaeaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagbjbaaaacaaaaaabacaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaa
jgahbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaafaaaaaaegiccaaa
aaaaaaaaagaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkbabaaaafaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadaaaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"!!ARBfp1.0
# 13 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 2 } };
TEMP R0;
TEMP R1;
TEX R1.w, fragment.texcoord[3], texture[1], CUBE;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MOV result.color.w, fragment.texcoord[5];
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.x, R0.x;
MUL R1.xyz, R1.x, fragment.texcoord[2];
MUL R1.w, R0, R1;
DP3_SAT R0.w, fragment.texcoord[1], R1;
MUL R0.xyz, fragment.texcoord[5], c[0];
MUL R1.x, R1.w, c[1];
MUL R0.xyz, R0, R0.w;
MUL result.color.xyz, R0, R1.x;
END
# 13 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c1, 2.00000000, 0, 0, 0
dcl t2.xyz
dcl t1.xyz
dcl t3.xyz
dcl t5
dp3 r0.x, t3, t3
mov r0.xy, r0.x
texld r2, r0, s0
texld r0, t3, s1
dp3 r0.x, t2, t2
rsq r1.x, r0.x
mul r1.xyz, r1.x, t2
mul r0.x, r2, r0.w
mul_pp r0.x, r0, c1
dp3_pp_sat r1.x, t1, r1
mul r2.xyz, t5, c0
mul r1.xyz, r2, r1.x
mul r0.xyz, r1, r0.x
mov_pp r0.w, t5
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
// 13 instructions, 3 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmibmaanhegfhgebjgfckekinpiclngbeabaaaaaaamadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomabaaaa
eaaaaaaahlaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaa
bacaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkbabaaaafaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"agal_ps
c1 2.0 0.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaacaaahacafaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, v5, c0
ciaaaaaaabaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r0.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaabaaaaaaafbababb tex r0, v3, s1 <cube wrap linear point>
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r0.x
adaaaaaaaaaaabacabaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r1.w, r0.w
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
bgaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r1.x, r1.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa mul r0.x, r0.x, c1
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r1.xyzz, r0.x
aaaaaaaaaaaaaiacafaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.w, v5
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
// 13 instructions, 3 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedllanjeideokngnjhhgonjfkkfphknfmoabaaaaaagaaeaaaaaeaaaaaa
daaaaaaaiaabaaaaheadaaaacmaeaaaaebgpgodjeiabaaaaeiabaaaaaaacpppp
baabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaabaaahla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaia
aeaacplabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkaaiaaaaad
aaaaaiiaadaaoelaadaaoelaabaaaaacaaaaadiaaaaappiaecaaaaadaaaaapia
aaaaoeiaabaioekaecaaaaadabaaapiaadaaoelaaaaioekaafaaaaadaaaacbia
aaaaaaiaabaappiaacaaaaadaaaaabiaaaaaaaiaaaaaaaiaceaaaaacabaaahia
abaaoelaaiaaaaadaaaadciaacaaoelaabaaoeiaafaaaaadabaaahiaaeaaoela
aaaaoekaafaaaaadaaaaaoiaaaaaffiaabaabliaafaaaaadaaaachiaaaaaaaia
aaaabliaabaaaaacaaaaciiaaeaapplaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
pcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaabacaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
aaaaaaaadiaaaaaiocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbcbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkbabaaaafaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadaaaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
"!!ARBfp1.0
# 10 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 2 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[3], texture[0], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[2];
MUL R0.xyz, fragment.texcoord[5], c[0];
DP3_SAT R1.x, fragment.texcoord[1], R1;
MUL R0.w, R0, c[1].x;
MUL R0.xyz, R0, R1.x;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, fragment.texcoord[5];
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
"ps_2_0
; 10 ALU, 1 TEX
dcl_2d s0
def c1, 2.00000000, 0, 0, 0
dcl t2.xyz
dcl t1.xyz
dcl t3.xy
dcl t5
texld r0, t3, s0
dp3 r0.x, t2, t2
rsq r0.x, r0.x
mul r1.xyz, r0.x, t2
mul_pp r0.x, r0.w, c1
dp3_pp_sat r1.x, t1, r1
mul r2.xyz, t5, c0
mul r1.xyz, r2, r1.x
mul r0.xyz, r1, r0.x
mov_pp r0.w, t5
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddlagaeffgggjojnblaiknbdlaooljhknabaaaaaalaacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaabaaaa
eaaaaaaageaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaabacaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagbjbaaaaeaaaaaaagijcaaaaaaaaaaaagaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkbabaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
"agal_ps
c1 2.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v3, s0 <2d wrap linear point>
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r0.x, v2
adaaaaaaaaaaabacaaaaaappacaaaaaaabaaaaoeabaaaaaa mul r0.x, r0.w, c1
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
bgaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r1.x, r1.x
adaaaaaaacaaahacafaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, v5, c0
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r1.xyzz, r0.x
aaaaaaaaaaaaaiacafaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.w, v5
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 112 // 112 used size, 4 vars
Vector 96 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefieceddjfbacnndndbchhbkadbfkdckhdefnbcabaaaaaameadaaaaaeaaaaaa
daaaaaaaeaabaaaaniacaaaajaadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
neaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaacpla
bpaaaaacaaaaaajaaaaiapkaceaaaaacaaaaahiaabaaoelaaiaaaaadaaaadbia
acaaoelaaaaaoeiaafaaaaadaaaaaoiaadaabllaaaaablkaafaaaaadaaaaahia
aaaaaaiaaaaabliaabaaaaacabaaadiaaaaabllaecaaaaadabaacpiaabaaoeia
aaaioekaacaaaaadaaaaaiiaabaappiaabaappiaafaaaaadaaaachiaaaaappia
aaaaoeiaabaaaaacaaaaciiaadaapplaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcjaabaaaaeaaaaaaageaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaabacaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagbjbaaaaeaaaaaaagijcaaa
aaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkbabaaaaeaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadaaaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}

#LINE 223

        }
		
	} 
	
	FallBack "VertexLit"
}